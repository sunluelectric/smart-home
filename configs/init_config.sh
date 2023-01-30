#!/bin/bash

cd ~
# update system
echo "update system..."
sudo yum updateinfo
sudo yum update

# install curl
echo "install curl..."
sudo yum install curl

# install git
sudo yum install git

# configure vim
# download vim.plug tool
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# download/create .vimrc
curl https://raw.githubusercontent.com/sunluelectric/smart-home/master/configs/.vimrc > ~/.vimrc
# install plugin
vim +PlugInstall +qall

# install openssh
sudo yum install openssh
sudo yum install openssh-clients openssh-server
# enable and start openssh status
sudo systemctl status sshd
sudo system enable sshd --now
sudo systemctl status sshd

# install ftp server
sudo yum install vsftpd
# enable and start ftp server
sudo systemctl status vsftpd
sudo systemctl enable vsftpd --now
sudo systemctl status vsftpd
# configure ftp server
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



