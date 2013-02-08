#!/bin/bash


if [ ! -f /etc/default/vpn-ssh.conf ]; then
    cp vpn-ssh.conf /etc/default/
else
    echo Config file exist. Not touching
fi;

if [ ! -f /etc/default/vpn-ssh.conf ]; then
    cp vpn-ssh /etc/init.d/
else
    echo initscript exsist. Not touching
fi;

exit 0

echo TODO:
read -p "IP to vpnserver: " IP
echo $IP     vpnserver >> /etc/hosts

echo ssh-keygen -t dsa -N "" -f ~/.ssh/vpn-ssh-key
echo ssh-copy-id -i ~/.ssh/vpn-ssh-key vpn@vpnserver

echo "### Add the following to the vpnservers sudofile:"
echo Cmnd_Alias VPN=/usr/sbin/pppd
echo vpn ALL=NOPASSWD: VPN
