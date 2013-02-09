#!/bin/bash


if [ ! -f /etc/default/vpn-ssh.conf ]; then
    echo Installing config file
    echo Remember to edit /etc/default/vpn-ssh.conf
    cp vpn-ssh.conf /etc/default/
else
    echo Config file exist. Not touching
fi;

if [ ! -f /etc/init.d/vpn-ssh ]; then
    echo Installing initscript
    cp vpn-ssh /etc/init.d/
else
    echo initscript exsist. Not touching
fi;


echo "# TODO:"
read -p "vpnserver name (default: vpnserver): " VPNSERVER

if [ -z "$VPNSERVER" ]; then 
    VPNSERVER=vpnserver
fi

IP=$(getent ahosts $VPNSERVER | grep STREAM| awk '{print $1}')

if [ -z "$IP" ]; then 
    read -p "IP to vpnserver: " IP
    echo $IP     vpnserver >> /etc/hosts
fi

echo ssh-keygen -t dsa -N "" -f ~/.ssh/vpn-ssh-key
echo ssh-copy-id -i ~/.ssh/vpn-ssh-key vpn@vpnserver

echo "# Do this: OR"
SSH_KEY=$(cat ~/.ssh/vpn-ssh-key)
echo command="sudo \${SSH_ORIGINAL_COMMAND#* }" $SSH_KEY

echo "### Add the following to the vpnservers sudofile:"
echo Cmnd_Alias VPN=/usr/sbin/pppd
echo vpn ALL=NOPASSWD: VPN
