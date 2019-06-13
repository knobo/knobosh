#!/bin/bash

cd ~/prog

if [[ $1 =~ / ]]; then
    echo cloning $1
    git clone https://github.com/${1}.git
else
    echo cloning knobo/$1
    USER=knobo/
    git clone git@github.com:${USER}${1}.git;
fi




