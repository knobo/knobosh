#!/bin/bash

PID=$(pidof tar);
if [ -z "$PID" ]; then
  echo Error: tar is not running
  exit 0
fi

FDINFO=/proc/$PID/fdinfo/3;
SIZE=$(stat -L --printf "%s" /proc/$PID/fd/3);
FILE=$(readlink /proc/$PID/fd/3)

while [ -f $FDINFO ] ;  do
    awk  -v size=$SIZE -v file=$FILE \
	'/pos:/ { printf "%s:   %3.2f %%  (%s/%s) bytes\r" ,file ,($2/size*100),$2,size;}' $FDINFO;
    sleep .5;
done

echo 
