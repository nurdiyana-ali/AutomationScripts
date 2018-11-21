#!/usr/bin/expect -f
#################################
# Created by Nurdiyana Ali      #
# ./create_user <IP address>    #
# Adds user with SUDO previlege #
#################################

#list of prompts; SLES uses >, RHEL uses $
set prompt "(%|#|>|\\\$ )"
set prompt [string trim $prompt]
#SUPER USER credentials
set super_user "superuser"
set my_pass "Password"
#USER TO BE ADDED credentials
set user "usertobeadded"
set new_pass "passwordforusertobeadded"

set server [lindex $argv 0]
set send_slow {10 .001}
set timeout 20
spawn ssh -o StrictHostKeyChecking=no -l $super_user $server

expect "?assword: "
send "$my_pass\r"
expect -re $prompt
send -s "/usr/bin/sudo su - \r"
expect "?assword: "
send "$my_pass\r"
expect -re $prompt
send -s -- "/usr/sbin/useradd -d /home/$user -m -s /bin/bash $user \r"
send -s -- "echo $user 'ALL=(ALL) ALL' >> /etc/sudoers\r"
expect -re $prompt
send -s "/usr/bin/passwd $user \r"
expect "?assword:"
send "$new_pass\r"
expect "?assword:"
send "$new_pass\r"
expect -re $prompt
send -s "exit\r"
expect -re $prompt
send -s "exit\r"
expect -re $prompt
