# Install and configure ansible on the server
<p>Install and configure Ansible on CentOS 8, exchanged SSH keys from master to slave node, and Test the Ansible setup.</p>

<div>
<p>Table of Contents</p>
  <ol>
    <li><a href="#prerequisites">Prerequisites:</a></li>
    <li><a href="#install-ansible-on-centos-8">Install Ansible on CentOS 8</a></li>
    <li><a href="#3create-inventory-file-in-ansible">Create Inventory file in Ansible</a></li>
    <li><a href="#4configuration-of-ansible-server">Configure ansible controller</a></li>
    <li><a href="#5add-user-to-the-sudo-group">Add User to the sudo Group</a></li>
    <li><a href="#6update-ssh-config-file">Update ssh_config file</a></li>
    <li><a href="#7establish-connection-between-server-and-node">Establish connection between server and node</a></li>
    <li><a href="#7setup-ssh-keys-and-share-it-among-managed-nodes">Setup SSH keys and share it among managed nodes</a></li>
  </ol>
</div>
<h2>1. Prerequisites:</h2>

<ul>
  <li>Minimum 3 instances of CentOS 1 for Ansible Controller and another 2 for Nodes</li>
  <li>SSH access with sudo privileges</li>
  <li>A good internet connection</li>
</ul>

<h2>2. Install Ansible on CentOS 8</h2>
<p>There are two methods from which you can install Ansible on CentOS 8.</p>
<ol>
  <li><a href="#install-ansible-on-centos-8-with-yum-package">Install Ansible on CentOS 8 with yum package</a></li>
  <li><a href="#install-ansible-on-centos-8-using-pip">Install Ansible on CentOS 8 using pip</a></li>
</ol>
<p>If ansible is aleady installed on your controller, you can skip to step 3</p>
<h3 id=install-ansible-on-centos-8-with-yum-package>Method 1.Install Ansible on CentOS 8 with yum package</h3>
<p>Now we are going to run the below commands on Ansible Controller</p>

<p>Step1: First we need to install the EPEL repository on CentOS 8:</p>

<pre><code>yum install epel-release -y</code></pre>

<p>Step2: If you want to check repositories on CentOS then run the below command:</p>

<pre><code>yum repolist | grep epel</code></pre>

<p>Output:</p>

<pre>epel               Extra Packages for Enterprise Linux 8 - x86_64
epel-modular       Extra Packages for Enterprise Linux Modular 8 - x86_64
</pre>

<p>Step3: Install ansible on CentOS 8 using the below command:</p>

<pre><code>yum install ansible -y</code></pre>

<p>Step4: To check ansible version:</p>

<pre><code>ansible --version</code></pre>

<p>Output:</p>

<pre>ansible &91;core 2.11.8]
config file = /etc/ansible/ansible.cfg
configured module search path = &91;'/home/centos/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
ansible python module location = /usr/local/lib/python3.6/site-packages/ansible
ansible collection location = /home/centos/.ansible/collections:/usr/share/ansible/collections
executable location = /usr/local/bin/ansible
python version = 3.6.8 (default, Sep 10 2021, 09:13:53) &91;GCC 8.5.0 20210514 (Red Hat 8.5.0-3)]
jinja version = 2.10.1
libyaml = True
</pre>

<p>Uninstall ansible on CentOS 8:</p>

<pre><code>yum remove ansible -y</code></pre>

<h3 id="install-ansible-on-centos-8-using-pip">Method 2. Install Ansible on CentOS 8 using python pip</h3>

<p>Now we are going to run the below commands on Ansible Controller</p>

<p>Step1: If you’re using Python3, install the python3-pip package.</p>

<pre><code>sudo dnf -y install python3-pip</code></pre>

<pre><code>sudo pip3 install --upgrade pip</code></pre>

<p>For Python2 users you have to install python2-pip</p>

<pre><code>sudo dnf -y install python2-pip</code></pre>

<pre><code>sudo pip2 install --upgrade pip</code></pre>

<p>Step2: Install ansible on CentOS using pip:</p>

<pre><code>pip3 install ansible</code></pre>

<p>Step3: To check ansible version:</p>

<pre><code>/usr/local/bin/ansible --version</code></pre>

<p>Output:</p>

<pre>
ansible &91;core 2.11.8]
config file = None
configured module search path = &91;'/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
ansible python module location = /usr/local/lib/python3.6/site-packages/ansible
ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
executable location = /usr/local/bin/ansible
python version = 3.6.8 (default, Apr 16 2020, 01:36:27) &91;GCC 8.3.1 20191121 (Red Hat 8.3.1-5)]
jinja version = 2.10.1
libyaml = True
</pre>

<h2>2. Create Inventory file in Ansible</h2>

<p>Step1: To test Ansible, firstly ensure that ssh is up and running on your Ansible Controller:</p>

<pre><code>sudo systemctl status sshd</code></pre>

<p>Step2: Create an Ansible inventory file using the below command in the Ansible controller:</p>
<p>The directory `ansible` and the file `hosts` could already be existing but just in case they don't exist, create them with the following commands:</p>
<pre><code>sudo mkdir /etc/ansible</code></pre>

<pre><code>sudo vi /etc/ansible/hosts</code></pre>

<p>Copy the IP address of your remote servers and paste into the host file</p>

<p>You can create a nodes group and paste ip address like below:</p>

<pre><code>[VM-Nodes]
192.168.xx.xx
172.98.xx.xx</code></pre>

<h2>3. Configuration of Ansible Controller</h2>

<p>Step1: Now this host file is only working after updating ansible.cfg file so we need to update config file in Ansible Controller using below command:</p>

<pre><code>sudo vi /etc/ansible/ansible.cfg</code></pre>

<p>Then uncommited two file</p>

<pre><code>
inventory = /etc/ansible/hosts
sudo-user = root
</code></pre>

<p>Step2: Now, create one user in all these instance(Ansible Controller and nodes)</p>

<pre><code>sudo adduser ansible</code></pre>

<pre><code>sudo passwd ansible</code></pre>

<p>now navigate the Ansible user</p>

<pre><code>su - ansible</code></pre>

<p> Try to create some files or install a package</p>

<p>you got some error like this</p>

<p><strong>This ansible user doesn&8217;t have sudo privileges right now</strong>.</p>

<p>If you want to give sudo privileges to an ansible user then run the below command</p>

<h2>4. Add User to the sudo Group</h2>

<p>Step1: Then give some privileged in all nodes(Ansible Controller and node) using below command:</p>

<pre><code>sudo visudo</code></pre>

<p>go to inside this file and add</p>

<pre><code>ansible ALL=(ALL) NOPASSWD:ALL</code></pre>

<h2>5. Update ssh_config file</h2>

<p>For SSH connection to node from Ansible Controller make changes in sshd_config file</p>

<p>Step1: Now we have to some changes in ssh-config file in Ansible Controller and  nodes:</p>

<pre><code>vi /etc/ssh/sshd_config</code></pre>

<p>Then you need to uncomment these two lines</p>

<pre>PubkeyAuthentication yes
PasswordAuthentication yes
</pre>

<p>Now we need to restart sshd service in Ansible Controller and nodes:</p>

<pre><code>sudo systemctl restart sshd</code></pre>

<pre><code>sudo systemctl status sshd</code></pre>

<h2>6. Establish connection between server and node</h2>

<p>Go to Ansible Controller and run the below command</p>

<p>Step1: login to Ansible in Ansible Controller using the below command:</p>

<pre><code>su - ansible</code></pre>

<p>Step2: Run the below command to connect node:</p>

<pre><code>ssh ip_address ( node ip)</code></pre>


<h2 id="setup-ssh-keys-and-share-it-among-managed-nodes">7. Setup SSH keys and share it among managed nodes</h2>

<p>To communicate with the client we have to generate SSH key on the Ansible Controller node and exchange it with Slave/Client Systems.</p>

<p>Step1: we need to generate ssh keygen in Ansible Controller</p>

<pre><code>ssh-keygen</code></pre>

<p>Step2:Now run the below command using the private IP of your node:</p>

<pre><code>ssh-copy-id ansible@{private address }</code></pre>



