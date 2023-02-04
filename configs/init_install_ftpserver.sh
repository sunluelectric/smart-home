#!/bin/bash

cd ~
# install ftp server
echo "Install vsftpd..."
sudo yum install vsftpd
# enable and start ftp server
echo "Enable and start vsftpd"
sudo systemctl status vsftpd
sudo systemctl enable vsftpd --now
sudo systemctl status vsftpd
# configure ftp server
echo "Make sure that /etc/vsftpd/vsftpd.conf has been configured correctly before proceeding."
echo "Important parameters are listed as follows."
echo "anonymous_enable=NO"
echo "local_enable=YES"
echo "write_enable=YES"
echo "listen=NO"
echo "listen_ipv6=YES"
echo "pasv_enable=YES"
echo "pasv_max_port=10100"
echo "pasv_min_port=10090"
# check /etc/vsftpd/vsftpd.conf for vsftpd configurations
# add the following to the configuration file
# anonymous_enable=NO
# local_enable=YES
# write_enable=YES
# listen=NO
# listen_ipv6=YES
# pasv_enable=Yes
# pasv_max_port=10100
# pasv_min_port=10090
# add port to firewall
sudo firewall-cmd --state
sudo firewall-cmd --list-all
sudo firewall-cmd --zone=public --add-port=20/tcp --permanent
sudo firewall-cmd --zone=public --add-port=21/tcp --permanent
sudo firewall-cmd --zone=public --add-port=990/tcp --permanent
sudo firewall-cmd --zone=public --add-port=10090-10100/tcp --permanent
sudo systemctl restart vsftpd
sudo firewall-cmd --reload


