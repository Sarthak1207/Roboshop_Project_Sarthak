infra:
	terraform init
	terraform apply -auto-approve

ansible:
	ansible-playbook -i ${tool_name}-internal.$(domanin_name) -e ansible_user=ec2-user ansible_password=Devops321 -e tool_name=$(tool_name) -e vault_token=${vault_token} main.yml
