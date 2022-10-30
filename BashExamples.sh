# Use grep to delete a line from a file.

grep -v 'line to delete' testfile.txt > tmpfile && mv tmpfile testfile.txt
