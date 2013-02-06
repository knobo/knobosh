#  -*- Mode: shell-script -*-
# 
#  To be sourced or included in bashrc
# 


alias ls="lsd --color=always -h --group-directories-first"

highlight () {  egrep --color=always "$1|" "$2" ; }




