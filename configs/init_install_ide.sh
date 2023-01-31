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
conda activate base
conda install conda
conda update --all
echo "Create new conda environment shserver-dev"
conda create --name shserver-dev
echo "Install packages"
conda activate shserver-dev
conda install conda
conda install numpy scipy pandas
conda install matplotlib
conda install scikit-learn tensorflow pytorch
conda update --all
conda deactivate
conda deactivate

# R related (see https://docs.posit.co/resources/install-r/)
cd ~/Downloads
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
export R_VERSION=4.2.2 # select version
curl -O https://cdn.rstudio.com/r/rhel-9/pkgs/R-${R_VERSION}-1-1.x86_64.rpm
sudo dnf install R-${R_VERSION}-1-1.x86_64.rpm
/opt/R/${R_VERSION}/bin/R --version # verification of installation
sudo ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R # create link
sudo ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript # create link

# MATLAB/Octave
sudo yum install epel-release
yum install octave

