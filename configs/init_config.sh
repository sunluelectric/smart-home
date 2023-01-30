#!/bin/bash

cd ~
# update system
echo "Update system..."
sudo yum updateinfo
sudo yum update

# install curl
echo "Install curl..."
sudo yum install curl

# install git
echo "Install git..."
sudo yum install git

# configure vim
echo "Configure vim..."
# download plug.vim tool
echo "Download plug.vim to ~/.vim/autoload/plug.vim..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# download/create .vimrc
echo "Download .vimrc by sunluelectric"
curl https://raw.githubusercontent.com/sunluelectric/smart-home/master/configs/.vimrc > ~/.vimrc
# install plugin
echo "Install plug-in"
vim +PlugInstall +qall

# install openssh
echo "iInstall open-ssh"
sudo yum install openssh
sudo yum install openssh-clients openssh-server
# enable and start openssh status
echo "Enable and start open-ssh"
sudo systemctl status sshd
sudo system enable sshd --now
sudo systemctl status sshd

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



