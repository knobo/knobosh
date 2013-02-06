#  -*- Mode: shell-script -*-
# 
#  To be sourced or included in bashrc
# 


alias lsd="ls --color=always -h --group-directories-first"
alias ls="ls --color=always -Fh"

highlight  () { 
    egrep --color=always "$1|" "$2" ; 
}

interfaces () { 
    ip link show | awk '/^[0-9]*:/ {sub(":","",$2); print $2}';
}

ipaddresses () {
    for iface in $( interfaces ) ; do 
	ip address show $iface | awk -v iface=$iface \
	    '/inet / {printf "%7s: %s\n", iface , $2}';
    done
}
