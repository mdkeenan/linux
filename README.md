<h1>How it Works</h1>

<ol>
 <li>When setup.sh is ran it checks to see if the current user is root.
   <ol>
     <li>If yes then it runs setup-commands.sh.</li>
     <li>If no then inform the user and tell them to run bashrc-setup.sh instead.</li>
   </ol>
  </li>
</ol>
   
<img width="275" alt="bashrc1" src="https://user-images.githubusercontent.com/19628173/168522641-af113736-9cd4-4903-8585-6716642fbfb5.png">

<h3>source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc-setup.sh)</h3>
