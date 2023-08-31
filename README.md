# Auto-configuration of Virtual Machines with Ansible
![image](https://github.com/Ndarugaa/Auto-configuration-of-virtual-Machines-with-ansible/assets/68260816/0ff9949c-ccd3-47f4-99d9-116e8bc2b5ba)

<p>Ansible is a server management tool. <br>It is used to <strong>manage and administer multiple servers</strong> from a central computer. 
<h6>Ansible doesn’t need any configuration on the server side as Chef or Puppet. You just install Ansible on your computer and manage or administer servers via SSH.</h6> </p>

<p>To run the script from the GitHub repository, in your terminal, you'll need to follow these steps:</p>

<h4>Download the Scripts</h4>
<p>First, you need to download the script to your Centos 8 Virtual Machine. You can use the wget command to do this directly from the terminal:</p>

<pre><code>wget https://raw.githubusercontent.com/Ndarugaa/Auto-configuration-of-virtual-Machines-with-ansible/main/install-ansible.sh
</code></pre>
This command will download the script and save it as install-ansible.sh in your current directory.

<h4>Make the Script Executable:</h4>
<p>Before you can run the script, you need to make it executable. Use the chmod command for this:
</p>
<pre><code>sudo chmod +x install-ansible.sh
</code></pre>
<p>Run the Script: Once the script is executable, you can run it using the following command:</p>
<pre><code>./install-ansible.sh
</code></pre>
<p>This will execute the script, which will then perform its tasks.</p>

<h6>Please note that you need to have the necessary permissions to download, execute, and modify files on your system.</h6>