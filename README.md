Test task: wordpress
======================

## Steps:

### Dev
----------------------
siteplus/ansible.cfg  

    [defaults]
    inventory = hosts.ini
    roles_path = ~/roles
    host_key_checking = yes
    log_path = siteplus.log
    bin_ansible_callbacks = True
    stdout_callback = debug
    become = yes
    remote-user = root
    


nano /etc/ansible/hosts

    [test]
    centos ansible_ssh_host=%remote%

ansible test -m ping  

### remote:  
----------------------
nano /etc/ssh/sshd_config

    PubkeyAuthentication yes
    AuthorizedKeysFile .ssh/authorized_keys

service sshd restart

### local:
----------------------
ssh-keygen -t rsa  
ssh-copy-id -i ~/.ssh/id_rsa.pub root@%remote%  

yum clean all && yum update -y && yum install -y epel-release  
yum install -y ansible && mv /etc/ansible/hosts /etc/ansible/hosts.default  

yum install -y git  
git clone https://github.com/vvsco/siteplus.git  
cd ~/siteplus
git remote add wp https://github.com/vvsco/siteplus.git  
ansible-galaxy install thorian93.ansible_role_wordpress --roles-path roles  

