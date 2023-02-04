#!/bin/bash

cd ~
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
