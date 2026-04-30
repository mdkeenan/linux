#!/usr/bin/env bash

# Exit immediately on errors, undefined variables, or failed pipes
set -euo pipefail

# URL where SSH public keys are fetched from (sshid.io endpoint)
URL="https://sshid.io/mkeenan"

# Define SSH directory and authorized_keys file paths
SSH_DIR="$HOME/.ssh"
AUTH_KEYS="$SSH_DIR/authorized_keys"

# -----------------------------
# ANSI COLOR DEFINITIONS
# -----------------------------
# Used to make output easier to read in terminal

RED='\033[0;31m'     # Errors / rejected keys
GREEN='\033[0;32m'   # सफल / successfully added keys
YELLOW='\033[0;33m'  # Warnings / skipped keys
BLUE='\033[0;34m'    # Informational messages
NC='\033[0m'         # Reset color (No Color)

# -----------------------------
# FETCH KEYS FROM REMOTE SOURCE
# -----------------------------
echo -e "${BLUE}Fetching SSH keys from:${NC}"
echo "$URL"
echo

# Use curl:
# -f = fail on HTTP errors
# -s = silent (no progress bar)
KEYS="$(curl -fs "$URL")"

# If nothing was returned, exit safely
if [[ -z "$KEYS" ]]; then
  echo -e "${RED}Error: No keys retrieved.${NC}"
  exit 1
fi

# Display keys so user can see what is being processed
echo -e "${BLUE}----- BEGIN RETRIEVED KEYS -----${NC}"
echo "$KEYS"
echo -e "${BLUE}----- END RETRIEVED KEYS -----${NC}"
echo

# -----------------------------
# ENSURE SSH DIRECTORY SETUP
# -----------------------------

# Create ~/.ssh if it does not exist
mkdir -p "$SSH_DIR"

# Set secure permissions (required by SSH or it will ignore keys)
chmod 700 "$SSH_DIR"

# Create authorized_keys file if missing
touch "$AUTH_KEYS"

# Set strict permissions for authorized_keys
chmod 600 "$AUTH_KEYS"

# Fix ownership (important if script was run with sudo)
chown "$USER":"$USER" "$SSH_DIR" "$AUTH_KEYS" 2>/dev/null || true

# -----------------------------
# COUNTERS FOR REPORTING
# -----------------------------
ADDED=0       # Number of new keys added
SKIPPED=0     # Number of duplicate keys skipped
REJECTED=0    # Number of invalid keys rejected

# -----------------------------
# PROCESS EACH KEY LINE
# -----------------------------
# Loop through each key returned from sshid.io
while IFS= read -r key; do

  # Skip empty lines
  [[ -z "$key" ]] && continue

  # Extract key type (field 1) and key data (field 2)
  KEY_TYPE="$(awk '{print $1}' <<< "$key")"
  KEY_DATA="$(awk '{print $2}' <<< "$key")"

  # -----------------------------
  # VALIDATION: KEY TYPE CHECK
  # -----------------------------
  # Ensure key type includes "@openssh.com"
  # This ensures we're only accepting modern SK-based keys
if [[ "$KEY_TYPE" != "sk-ecdsa-sha2-nistp256@openssh.com" && "$KEY_TYPE" != "ssh-ed25519" ]]; then
  echo -e "${RED}Rejected (unsupported key type):${NC}"
  echo "$key"
  echo
  ((REJECTED++))
  continue
fi
  # -----------------------------
  # VALIDATION: KEY DATA CHECK
  # -----------------------------
  # Ensure key actually has base64 data (not malformed)
  if [[ -z "$KEY_DATA" ]]; then
    echo -e "${RED}Rejected (missing key data):${NC}"
    echo "$key"
    echo
    ((REJECTED++))
    continue
  fi

  # -----------------------------
  # DUPLICATE CHECK
  # -----------------------------
  # Prevent adding the same key multiple times
  if grep -qxF "$key" "$AUTH_KEYS"; then
    echo -e "${YELLOW}Skipped (already exists):${NC}"
    echo "$key"
    echo
    ((SKIPPED++))
  else
    # Append key to authorized_keys
    echo "$key" >> "$AUTH_KEYS"

    echo -e "${GREEN}Added key:${NC}"
    echo "$key"
    echo

    ((ADDED++))
  fi

done <<< "$KEYS"

# -----------------------------
# FINAL SUMMARY OUTPUT
# -----------------------------
echo -e "${BLUE}Done.${NC}"
echo -e "${GREEN}Added: $ADDED${NC}"
echo -e "${YELLOW}Skipped duplicates: $SKIPPED${NC}"
echo -e "${RED}Rejected: $REJECTED${NC}"
