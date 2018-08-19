#! /usr/bin/env bash

read var

for file in `ls`
do
	if [ -f "$file" ]
	then 
		if [[ $file == *$var* ]]
		then 
			gedit $file &
		fi
	fi
done
