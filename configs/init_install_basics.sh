#!/bin/bash

cd ~

# update system
echo "Update system..."
sudo yum updateinfo
sudo yum update

# install gcc
sudo yum install gcc

# install curl
echo "Install curl..."
sudo yum install curl

# install openssh
echo "Install open-ssh"
sudo yum install openssh
sudo yum install openssh-clients openssh-server
# enable and start openssh status
echo "Enable and start open-ssh"
sudo systemctl status sshd
sudo system enable sshd --now
sudo systemctl status sshd

# install git
echo "Install git..."
sudo yum install git
git config --global user.name 'sunlu'
git config --global user.email sunlu.electric@gmail.com

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
