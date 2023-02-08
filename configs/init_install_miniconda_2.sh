#!/bin/bash

cd ~
# python related
echo "Configure conda environments..."
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
