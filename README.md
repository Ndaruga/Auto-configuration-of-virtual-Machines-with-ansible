# Auto-configuration of Virtual Machines with Ansible
![image](https://github.com/Ndarugaa/Auto-configuration-of-virtual-Machines-with-ansible/assets/68260816/0ff9949c-ccd3-47f4-99d9-116e8bc2b5ba)

<p>Ansible is a server management tool. <br>It is used to <strong>manage and administer multiple servers</strong> from a central computer. 
<h6>Ansible doesn’t need any configuration on the server side as Chef or Puppet. You just install Ansible on your computer and manage or administer servers via SSH.</h6> </p>

<h2>Getting Started</h2>
<p>To Begin with, If your Virtual Machines are lunched locally, then you might need to install a hypervisor like <a href="https://www.virtualbox.org/wiki/Downloads" target="_blank">Virtual Box</a> in your local PC (Host OS).</p>
<p>Once you have Virtual Box running, you can install as many VMs as you need.</p>
<p>We will use CentOS 8 which can be downloaded <a href="http://isoredirect.centos.org/centos/8-stream/isos/x86_64/" target="_blank"> Here</a> as the controller/server and 2 other VMs for this project.</p>

> NOTE: The choice of these VMs depends on which ones can run successfully on Virtual Box.

<br>
  Here are two tutorials on installing VMs in virtual Box
  <ul>
    <li><a href="https://www.cyberpratibha.com/how-to-install-centos-8-on-virtualbox-step-by-step-guide-for-beginners/" target="_blank">How to install CentOS 8 on virtual Box</a></li>
    <li><a href="https://linuxconfig.org/how-to-install-ubuntu-20-04-on-virtualbox" target="_blank">How to install Ubuntu 20.04 Focal Fossa in VirtualBox</a></li>
  </ul>
</p>
<h2>Managing VMs with Host Machine's CLI</h2>

> This part is optional and can also be done with the Virtual Box interface
<p>Virtual Box has a Module called <strong>VBoxManager</strong> which can be used to manage and control all installed Virtul Machines through the Host Machine's Command Line Interface (CLI)</p>
<p>Below is a description of managing the VMs using Windows and Linux distributions</p>

<h3>Managing VMs with Windows CMD</h3>
<p>In Windows, you will need to download the <a href="https://github.com/Ndarugaa/Auto-configuration-of-virtual-Machines-with-ansible/blob/main/vm-manager-windows.bat" target="_blank">Vm-Manager-windows.bat</a> file to your local machine (Host).</p>
<p>Any of the below Methods can be used</p>

  *  The file can be downloaded by opening the code on github and click `Ctrl`+`Shift`+`S`.
  *  Alternatively, you can download the file by clicking the download button as shown below.
![image](https://github.com/Ndarugaa/Auto-configuration-of-virtual-Machines-with-ansible/assets/68260816/15cb4ea9-771c-47e8-addd-f43ac2bf2422)
<br>

if you have Virtual Box installed in a another location other than `C:\Program Files\Oracle\VirtualBox`, you need to change the file path of the `vm-manager-windows.bat` file in `line 6` with the path to where virtual box is installed.
<br>
Execute the file by double clicking the `vm-manager-windows.bat` file or running it as an administrator.
<p>An in-depth introduction of <strong>Managing VMs with VBoxManage</strong> can be found <a href="https://www.cyberithub.com/vboxmanage-an-introduction-to-virtualbox-cli-with-examples/" target="_blank">here</a>.</p>
<h3>Managing VMs with Linux Terminal</h3>
<p>Similar to windows OS, the <strong>VBoxManage</strong> module is used to manage VMs.</p>

First, you need to download the script `vboxmanage-linux.sh` to your local PC using the command:
<pre><code>wget https://raw.githubusercontent.com/Ndarugaa/Auto-configuration-of-virtual-Machines-with-ansible/main/vboxmanage-linux.sh</code></pre>
<p>Next, you need to give permissions and execute the file</p>
<pre><code>sudo chmod +x vboxmanage-linux.sh</code></pre>
<pre><code>./vboxmange-linux.sh</code></pre>

## Configuring Ansible on CentOS 8
<p>First, you need to download the script  to your Centos 8 Virtual Machine. You can use the wget command to do this directly from the terminal:</p>

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
