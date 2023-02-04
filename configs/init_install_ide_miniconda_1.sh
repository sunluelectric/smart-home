#!/bin/bash

cd ~
# python related
echo "Install miniconda..."
echo "Download miniconda installation bash..."
cd ~/Downloads
wget "https://repo.anaconda.com/miniconda/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh"
echo "Carry out sha256sum check to the downloaded file..."
echo "00938c3534750a0e4069499baf8f4e6dc1c2e471c86a59caa0dd03f4a9269db6  Miniconda3-py310_22.11.1-1-Linux-x86_64.sh" | sha256sum --check
echo "Install miniconda..."
bash ./Miniconda3-py310_22.11.1-1-Linux-x86_64.sh
echo "Add conda to PATH..."
export PATH="$HOME/miniconda3/bin:$PATH"
conda config --set auto_activate_base false
echo "Restart the bash shell to proceed..."
read -p "Confirm restarting the bash shell now? [Y/n]: " -n 1
if [[ $REPLY =~ ^[Yy]$ ]]
    echo "Manually restart the bash shell later..."
then
    logout
fi
