sudo set-prompt workstation
sudo pip3.11 install ansible ansible-core
ansible -i /tmp/inv all -e ansible_user=ec2_user -e ansible_password=DevOps321 -m ping