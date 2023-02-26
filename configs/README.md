This document summarizes the configurations of the equipment used in the smart home project. More details of the project can be found at the following github repository [sunluelectric/smart-home](https://github.com/sunluelectric/smart-home "https://github.com/sunluelectric/smart-home").

# Server

## Hardware and OS

Beelink Mini S PC is used as this server. The hardware of the server is concluded as follows.

- Intel(R) Celeron(R) N5095A @ 2.00GHz (2.90GHz) CPU, architecture x86\_64
- Memory DDR4 NB 8G 2666, 8GiB, 2667MHz
- PCI Host Bridge, 32 bits, 33MHz
- JasperLake UHD Graphics
- AirDisk 128GB SS

The information of the OS is as follows.

- Red Hat Enterprise Linux 9
- Version 9.1 (Plow)

## Hostname Setup

Use `hostnamectl` to check hostname information. Edit `/etc/hostname` and `/etc/hosts` to either add `shserver` or replace the default with `shserver`. This shall change the hostname to `shserver`.

Reboot the server. The server hostname should have been changed. Use `hostnamectl` to double check the changed hostname.

## SSH Key Pairs Generation

Generate SSH key and register the machine on GitHub following the instructions given by [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent "Generating a new SSH key and adding it to the ssh-agent"). An SSH key helps to link a local repository to a remote repository in GitHub.

## Installation of Software

- Update system, install C language compiler, `curl` tool, SSH server, `git` tool, and configure Vim following ["init\_install\_basics.sh"](./init_install_basics.sh).

- Install FTP server, database management system and docker engine following the procedures given below.
  - FTP related: ["init_install_ftpserver.sh"](./init_install_ftpserver.sh).
  - Database related: ["init\_install\_database.sh"](./init_install_database.sh); MariaDB is used as the DBMS. More details are given [here](https://mariadb.com/kb/en/yum/ "https://mariadb.com/kb/en/yum/").
  - Docker engine related:
    - Web service related:

- Install IDEs as follows. 
  - Python related: ["init\_install\_miniconda\_1.sh"](./init_install_miniconda_1.sh) and [init\_install\_miniconda\_2.sh](init_install_miniconda_2.sh).
  - R related:[init\_install\_r.sh](init_install_r.sh).
  - MATLAB/Octave related: [init\_install\_matlab\_octave.sh](init_install_matlab_octave.sh).

## Switching Booting Target

Switch default booting target from `graphical.target` to `multi-user.target` as follows, to enable CLI as the default booting target.

```bash
systemctl get-default # check default target
sudo systemctl set-default multi-user.target
sudo reboot
```
