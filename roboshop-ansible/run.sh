git pull
if [ $# -ne 2]; then
    echo "Input Missing"
    echo "Usage bash run.sh <component-name> <env>"
    exit 1
fi

ansible-playbook -i $1-$2.sarthak1207.shop -e ansible_user=ec2-user -e ansible_password=DevOps321 -e env=$2 -e component=$1 roboshop.yml