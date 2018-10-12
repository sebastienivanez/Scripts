#! /usr/bin/env bash

read var

for file in `ls`
do
	if [ -f "$file" ]
	then 
		if [[ $file == *$var* ]]
		then 
			nedit -xrm '*font: -*-dina-medium-r-*-*-16-*-*-*-*-*-*-*' $file &
		fi
	fi
done

