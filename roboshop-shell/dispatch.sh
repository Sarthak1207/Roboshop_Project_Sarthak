#source is used to refer on any script which we want to use in existing script
source common.sh

#declaring varibale used in function
$app_name=dispatch
status_check $?

print_heading "install golang"
dnf install golang -y $>>$log_file
status_check $?

app_prerequsites
status_check $?

print_heading "Download the dependencies"
cd /app $>>$log_file
go mod init dispatch $>>$log_file
go get $>>$log_file
go build $>>$log_file
status_check $?

systemd_setup