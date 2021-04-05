Test task

Steps:

remote:
# nano /etc/ssh/sshd_config
    PubkeyAuthentication yes 
    AuthorizedKeysFile .ssh/authorized_keys
# service sshd restart

local:
# yum clean all && yum update -y && yum install -y epel-release
# yum install -y ansible && mv /etc/ansible/hosts /etc/ansible/hosts.default
# ssh-keygen -t rsa
# ssh-copy-id -i ~/.ssh/id_rsa.pub root@%remote%
# nano /etc/ansible/hosts
    [test]
    centos ansible_ssh_host=%remote%
# ansible test -m ping
# ansible-galaxy install thorian93.ansible_role_wordpress


