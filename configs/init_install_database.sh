#!/bin/bash

cd ~
# setup repository
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
# the above file will do the following:
# it adds MariaDB.repo under /etc/yum.repos.d/
# the added file automatically fetch the GPG public key to be used in the installation
# install mariadb server
sudo dnf install MariaDB-server
# enable and start mariadb
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service
# run secure installation wizzard
sudo mysql_secure_installation
# add administrator user account
cd ~/Downloads
echo "Add administrator user name and password to the DBMS: "
echo "Input administrator user name:"
read user_name
echo "Set administrator user password:"
read -s user_password
echo "Confirm password:"
read -s user_password_confirm
if [["$user_password"=="$user_password_confirm"]]
then
    echo "GRANT ALL PRIVILEGES ON *.* TO '"$user_name"'@'localhost' IDENTIFIED BY '"$user_password"' WITH GRANT OPTION;" > add_admin.sql
    echo "FLUSH PRIVILEGES;" >> add_admin.sql
    sudo mariadb mysql < add_admin.sql
    rm add_admin.sql
else
    echo "Password check failed. Please add administrator user manually later."
fi
