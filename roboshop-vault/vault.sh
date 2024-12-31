sudo -i
set-prompt vault
curl -L -o /etc/yum.repos.d/vault.repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install vault
systemctl start vault (run as root user)