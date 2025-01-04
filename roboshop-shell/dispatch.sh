#source is used to refer on any script which we want to use in existing script
source common.sh

#declaring varibale used in function
component=dispatch
rabiit_mq_pass=$1
#rabiit_mq_pass=roboshop123

if [ -z "$1" ]; then
    echo Input my rabbitmq password is missing
    exit 1
fi

golang_setup