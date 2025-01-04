#@ is used when no commond line is needed in command output

default:
	@git pull
	ansible-playbook -i $(component)-$(env).sarthak1207.shop -e ansible_user=ec2-user -e ansible_password=DevOps321 -e env=$(env) -e component=$(component) roboshop.yml