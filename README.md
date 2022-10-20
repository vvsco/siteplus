Test task: WordPress
======================

## Steps:

### Dev
----------------------
siteplus/ansible.cfg  

    [defaults]
    inventory = siteplus_hosts.ini
    #roles_path = ./roles
    host_key_checking = yes
    log_path = siteplus.log
    bin_ansible_callbacks = True
    stdout_callback = debug
    become = yes
    remote-user = root    

siteplus/hosts

    [WordPress]
    siteplus-wp ansible_host=10.10.0.3

siteplus/create_wp.sh

    #!/bin/bash
    git pull && ansible-playbook create_wp.yml

chmod 777 create_wp.sh  
ansible All -m ping  

### Remote:  
----------------------
/etc/ssh/sshd_config

    PubkeyAuthentication yes
    AuthorizedKeysFile .ssh/authorized_keys

service sshd restart

/etc/security/limits.conf

    #<domain>   <type>  <item>  <value>
    *           hard    nofile  1048576
    *           soft    nofile  1048576
    root        hard    nofile  1048576
    root        soft    nofile  1048576


### Prometheus
----------------------
yum clean all && yum update -y && yum install -y epel-release  
cd /opt  
wget https://github.com/prometheus/prometheus/releases/download/v2.26.0/prometheus-2.26.0.linux-amd64.tar.gz  
tar zxvf prometheus-2.26.0.linux-amd64.tar.gz  
cd prometheus-2.26.0.linux-amd64  
/opt/prometheus-2.26.0.linux-amd64/prometheus.yml

    global:
    scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
    evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.

    alerting:
    alertmanagers:
    - static_configs:
        - targets:
        - alertmanager:9093

    rule_files:
    # - "first_rules.yml"
    # - "second_rules.yml"

    scrape_configs:
    - job_name: 'prometheus'
        static_configs:
        - targets: ['localhost:9090']

firewall-cmd --permanent --zone=public --add-port=9090/tcp  
firewall-cmd --reload  
./prometheus  

### Local:
----------------------
ssh-keygen -t rsa  
ssh-copy-id -i ~/.ssh/id_rsa.pub root@%remote%  

yum clean all && yum update -y && yum install -y epel-release  
yum install -y ansible && mv /etc/ansible/hosts /etc/ansible/hosts.default  

yum install -y git  
git clone https://github.com/vvsco/siteplus.git  
cd ~/siteplus
git remote add wp https://github.com/vvsco/siteplus.git  

-ansible-galaxy install thorian93.ansible_role_wordpress --roles-path ./roles  
ansible-galaxy install inmotionhosting.wordpress_ultrastack --roles-path ./siteplus/roles  

