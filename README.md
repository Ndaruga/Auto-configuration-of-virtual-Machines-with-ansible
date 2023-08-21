# Auto-configuration of Virtual Machines with Ansible
![image](https://github.com/Ndarugaa/Auto-configuration-of-virtual-Machines-with-ansible/assets/68260816/0ff9949c-ccd3-47f4-99d9-116e8bc2b5ba)

<p>Ansible is a server management tool. <br>It is used to <strong>manage and administer multiple servers</strong> from a central computer. 
<h6>Ansible doesn’t need any configuration on the server side as Chef or Puppet. You just install Ansible on your computer and manage or administer servers via SSH.</h6> </p>
<p>We are going cover How to install and configure Ansible on CentOS 8, exchanged SSH keys from master to slave node, and Test the Ansible setup.</p>

<p>There are two methods from which you can install Ansible on CentOS 8.</p>

<div>
<p>Table of Contents</p>
  <ul>
    <li><a href="#prerequisites">Prerequisites:</a></li>
    <li><a href="#method-1install-ansible-on-centos-8-with-yum-package">Method #1.Install Ansible on CentOS 8 with yum package</a></li>
    <li><a href="#method-2install-ansible-on-centos-8-using-pip">Method #2.Install Ansible on CentOS 8 using pip</a></li>
    <li><a href="#3create-inventory-file-in-ansible">#3.Create Inventory file in Ansible</a></li>
    <li><a href="#4configuration-of-ansible-server">#4.Configure ansible controller</a></li>
    <li><a href="#5add-user-to-the-sudo-group">#5.Add User to the sudo Group</a></li>
    <li><a href="#6update-ssh-config-file">#6.Update ssh_config file</a></li>
    <li><a href="#7establish-connection-between-server-and-node">#7.Establish connection between server and node</a></li>
    <li><a href="#8setup-ssh-keys-and-share-it-among-managed-nodes">#8.Setup SSH keys and share it among managed nodes</a></li>
  </ul> </nav></div>
<h2><strong>Prerequisites:</strong></h2>

<ul>
  <li>Minimum 3 instances of CentOS 1 for Ansible server and another 2 for Nodes</li>
  <li>SSH access with sudo privileges</li>
  <li>A good internet connection</li>
</ul>

<h2><strong>Method #1.Install Ansible on CentOS 8 with yum package</strong></h2>

<p>Now we are going to run below commands on Ansible server&nbsp;</p>

<p>Step1: Firstly we need to install EPEL repository on CentOS 8:</p>

<code><pre>yum install epel-release -y</pre></code>

<p>Step2: If you wants to check repositories on CentOS then run the below command:</p>

<code><pre>yum repolist | grep epel</pre></code>

<p>Output:</p>

<pre class="wp-block-code"><code>epel               Extra Packages for Enterprise Linux 8 - x86_64
epel-modular       Extra Packages for Enterprise Linux Modular 8 - x86_64
</code></pre>

<p>Step3: Install ansible on CentOS 8 using below command:</p>

<code><pre>yum install ansible -y</pre></code>

<p>Step4: To check ansible version:</p>

<code><pre>ansible --version</pre></code>

<p>Output:</p>

<pre class="wp-block-code"><code>ansible &#91;core 2.11.8]
  config file = /etc/ansible/ansible.cfg
  configured module search path = &#91;'/home/centos/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.6/site-packages/ansible
  ansible collection location = /home/centos/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.6.8 (default, Sep 10 2021, 09:13:53) &#91;GCC 8.5.0 20210514 (Red Hat 8.5.0-3)]
  jinja version = 2.10.1
  libyaml = True
</code></pre>

<p>Uninstall ansible on CentOS 8:</p>

<code><pre>yum remove ansible -y</pre></code>

<h2 class="wp-block-heading"><span class="ez-toc-section" id="method-2install-ansible-on-centos-8-using-pip"></span><strong>Method</strong> #<strong>2.Install Ansible on CentOS 8 using pip</strong><span class="ez-toc-section-end"></span></h2>

<p>Now we are going to run below commands on Ansible server&nbsp;</p>

<p>Step1: If you’re using Python3, install the python3-pip package.</p>

<code><pre>sudo dnf -y install python3-pip</pre></code>

<code><pre>sudo pip3 install --upgrade pip</pre></code>

<p>For Python2 users you have to install python2-pip</p>

<code><pre>sudo dnf -y install python2-pip</pre></code>

<code><pre>sudo pip2 install --upgrade pip</pre></code>

<p>Step2: Install ansible on CentOS using pip:</p>

<code><pre>pip3 install ansible</pre></code>

<p>Step3: To check ansible version:</p>

<code><pre>/usr/local/bin/ansible --version</pre></code>

<p>Output:</p>

<pre class="wp-block-code"><code>
ansible &#91;core 2.11.8]
  config file = None
  configured module search path = &#91;'/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.6/site-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.6.8 (default, Apr 16 2020, 01:36:27) &#91;GCC 8.3.1 20191121 (Red Hat 8.3.1-5)]
  jinja version = 2.10.1
  libyaml = True
</code></pre>

<h2 class="wp-block-heading"><span class="ez-toc-section" id="3create-inventory-file-in-ansible"></span><strong>#3.Create Inventory file</strong> <strong>in Ansible</strong><span class="ez-toc-section-end"></span></h2>

<p>Step1: To test Ansible, firstly ensure that ssh is up and running on your Ansible server:</p>

<code><pre>sudo systemctl status sshd</pre></code>

<p>Step2: Create ansible inventory file using below command in Ansible server:</p>

<code><pre>sudo mkdir /etc/ansible&nbsp;&nbsp;</pre></code>

<code><pre>&nbsp;cd /etc/ansible</pre></code>

<code><pre>sudo touch hosts</pre></code>

<code><pre>sudo vi /etc/ansible/hosts</pre></code>

<p>Copy the IP address of your remote servers and paste in host file</p>

<p>You can create group and paste ip address like below:</p>

<pre class="wp-block-code"><code>&#91;devopshint]
65.2.140.xx
65.2.144.xx</code></pre>

<h2 class="wp-block-heading"><span class="ez-toc-section" id="4configuration-of-ansible-server"></span><strong>#4.Configuration of Ansible server</strong><span class="ez-toc-section-end"></span></h2>

<p>Step1: Now this host file is only working after updating ansible.cfg file so we need to update config file in Ansible server using below command:</p>

<code><pre>sudo vi /etc/ansible/ansible.cfg</pre></code>

<p>Then uncommited two file</p>

<pre class="wp-block-code"><code>i) inventory = /etc /ansible / hosts
ii) sudo-user = root
</code></pre>

<p>Step2: Now, create one user in all these instance(Ansible server and nodes)</p>

<code><pre>sudo adduser ansible</pre></code>

<code><pre>sudo passwd ansible</pre></code>

<p>now navigate the Ansible user&nbsp;</p>

<code><pre>su - ansible&nbsp;</pre></code>

<p>try to create a some file and install some package</p>

<p>you got some error like this&nbsp;</p>

<p><strong>This ansible user doesn&#8217;t have sudo privileges right now</strong>.&nbsp;</p>

<p>If you want to give sudo privileges to ansible user then run below command</p>

<h2 class="wp-block-heading"><span class="ez-toc-section" id="5add-user-to-the-sudo-group"></span><strong>#5.Add User to the sudo Group</strong><span class="ez-toc-section-end"></span></h2>

<p>Step1: Then give some privileged in all nodes(ansible server and node) using below command:</p>

<code><pre>&nbsp;&nbsp;sudo visudo&nbsp;</pre></code>

<p>go to inside this file and add&nbsp;</p>

<code><pre>ansible ALL=(ALL) NOPASSWD:ALL</pre></code>

<h2 class="wp-block-heading"><span class="ez-toc-section" id="6update-ssh-config-file"></span><strong>#6.Update ssh_config file</strong><span class="ez-toc-section-end"></span></h2>

<p>For SSH connection to node from Ansible server make changes in sshd_config file</p>

<p>Step1: Now we have to some changes in ssh-config file in Ansible server and  nodes:</p>

<code><pre>vi /etc/ssh/sshd_config</pre></code>

<p>Then you need to uncomment these two lines</p>

<pre class="wp-block-code"><code>PubkeyAuthentication yes
PasswordAuthentication yes
</code></pre>

<p>Now we need to restart sshd service in Ansible server and nodes:</p>

<code><pre>sudo systemctl restart sshd</pre></code>

<code><pre>sudo systemctl status sshd</pre></code>

<h2 class="wp-block-heading"><span class="ez-toc-section" id="7establish-connection-between-server-and-node"></span><strong>#7.Establish connection between server and node</strong><span class="ez-toc-section-end"></span></h2>

<p>&nbsp;Go to ansible server run the below command</p>

<p>Step1: login to ansible in ansible server using below command:</p>

<code><pre>su - ansible</pre></code>

<p>Step2: Run the below command to connect node:</p>

<code><pre>ssh ip_address ( node ip)</pre></code>

<h2 class="wp-block-heading"><span class="ez-toc-section" id="8setup-ssh-keys-and-share-it-among-managed-nodes"></span><strong><strong>#8.Setup SSH keys and share it among managed nodes</strong></strong><span class="ez-toc-section-end"></span></h2>

<p>To communicate with client we have to genrate SSH key on Ansible server node and exchange with Slave/Client Systems.</p>

<p>Step1: we need to generate ssh keygen in Ansible server</p>

<code><pre>ssh-keygen&nbsp;</pre></code>

<p>Step2: you need to inside .ssh:</p>

<code><pre>cd .ssh</pre></code>

<p>Step3:Now run the below command using private ip of your node:</p>

<code><pre>ssh-copy-id ansible@{private address }&nbsp;</pre></code>

