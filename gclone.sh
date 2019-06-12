#!/bin/bash

cd ~/prog

if [[ $1 =~ / ]]; then
    echo cloning $1
else
    echo cloning knobo/$1
    USER=knobo/
fi

git clone git@github.com:${USER}${1}.git;



