# Server Configuration

This document illustrates the configuration procedures of this server for the smart home project.

More details of the project can be found at the following github repository [sunluelectric/smart-home](https://github.com/sunluelectric/smart-home).

## Server Hardware

Beelink Mini S PC is used as this server. The information of the hardware can be obtained by using
```bash
sudo lshw
``` 

The hardware of the server is concluded as follows.

- Intel(R) Celeron(R) N5095A @ 2.00GHz (2.90GHz) CPU, architecture x86\_64
- Memory DDR4 NB 8G 2666, 8GiB, 2667MHz
- PCI Host Bridge, 32 bits, 33MHz
- JasperLake UHD Graphics
- AirDisk 128GB SS

## Server OS

The information of the OS of the server is stored in `/etc/os-release` as follows.

- Red Hat Enterprise Linux 9
- Version 9.1 (Plow)

## Change Hostname

Change hostname from the default (either `localhost` or not defined) to `shserver` as follows. Use
```bash
hostnamectl
```
to check hostname related information. Edit `/etc/hostname` and `/etc/hosts` to either add `shserver` or replace the default with `shserver`.

Reboot the server. The server hostname should have been changed. Use `hostnamectl` to double check the changed hostname.

## Initial Configurations

Install basic tools, software, and services following ["init\_config.sh"](./init_config.sh).

Generate SSH key and register the machine on GitHub following the instructions given by [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent "Generating a new SSH key and adding it to the ssh-agent").

Install IDEs following ["init\_install\_ide.sh"](./init_install_ide.sh)



## Appendix: Administration Commands


