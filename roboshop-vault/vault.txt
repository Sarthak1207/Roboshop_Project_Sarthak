sudo -i
set-prompt vault
curl -L -o /etc/yum.repos.d/vault.repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install vault
systemctl start vault (run as root user)

#initial root token - hvs.DVwJITQ8RSILyQJG700f4YQ0
#Key1 - 7hR+rpWbcYRu4Upo7/KtYPGoNnisqufxyYDN9WZtZ4g=