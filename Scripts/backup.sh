#!/bin/bash

# Checks if the file has been modified
# If it hasn't it returns
# If it has it updates the modified value and backs
# the file up
# $1 The file to back up
function check_for_backup
{
    hidden=${files[$1]}
    last_modified=`cat $hidden`
    current=`stat -c %Y $1`
    if [[ $current -ne $last_modified ]]
    then
        echo $current > $hidden
        pu.sh $1
    fi
}




# Add files here to create a backup chain
declare -A files=( 
                    ["bash_aliases"]=".aliases" 
                    ["bashrc"]=".brc"  
                    ["./converter.sh"]=".converter"
                    ["crontab"]=".crontab"   
                ) 

for file in "${!files[@]}";
do
    if [ ! -f "${files[$file]}" ]; #if hidden file doesn't exist create it
    then 
        touch "${files[$file]}"
    fi
    check_for_backup $file
done

