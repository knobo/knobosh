#!/bin/bash 

PROGRAM=tar
ONCE=""

while getopts "p:c:dnh?o" opt; do
    case $opt in
	d)
	    DEBUG=1
	    ;;
	p)
	    PID=$OPTARG
	    ;;
	c)
	    PROGRAM=$OPTARG
	    ;;
	n)
	    DRYRUN=yes
	    ;;
    o)
        ONCE=true
        ;;
	h|\?)
	    echo -e "Usage $0 [-dpcn]\n" >&2
	    exit 0;
	    ;;
  esac
done

if [ -z "$PID" ]; then
    PID=$(pidof -s ${PROGRAM:-tar});
    if [ -z "$PID" ]; then
	echo $PROGRAM not running
c	exit 0
    fi;
fi

for each in $(find /proc/$PID/fd -xtype f -printf "%f ") ; do
    # TODO, maybe show all files used
    FDESK=${FDESK:-$each}  
done

FDINFO=/proc/$PID/fdinfo/$FDESK;
SIZE=$(stat -L --printf "%s" /proc/$PID/fd/$FDESK);  
FILE=$(readlink /proc/$PID/fd/$FDESK)

if [ "$DEBUG" == 1 ]; then 
    echo FDESK: $FDESK 
    echo FDINFO: $FDINFO
    echo SIZE: $SIZE
    echo FILE: $FILE
    echo PID: $PID
    echo PROGRAM: $PROGRAM
    echo DRYRUN: $DRYRUN
fi

if [ "$DRYRUN" = yes ]; then
    exit 0
fi

if [[ ! -z "$ONCE" ]]
then
    awk  -v size=$SIZE -v file=$FILE \
	    '/pos:/ { printf "%s:   %3.2f %%  (%s/%s) bytes\r" ,file ,($2/size*100),$2,size;}' $FDINFO;
else

while [ -f "$FDINFO" ] ;  do
    awk  -v size=$SIZE -v file=$FILE \
	    '/pos:/ { printf "%s:   %3.2f %%  (%s/%s) bytes\r" ,file ,($2/size*100),$2,size;}' $FDINFO;
    sleep .5;
done
fi;
echo 
