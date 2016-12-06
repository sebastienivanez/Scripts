#! /usr/bin/env bash
echo "File or Directory ?"
read var

if [ "$var" = "f" ] || [ "$var" = "F" ] || [ "$var" = "file" ] || [ "$var" = "FILE" ]
then
	echo "File ?"
	read file
	search()
	{
		for list in `ls`
		do
			if [ -f "$list" ]
			then
				if [[ $list == *$file* ]]
				then
					echo "File $list is in " `pwd`
				fi
			elif [[ -d "$list" ]]
			then
				cd $list
				search
			fi
		done
		cd ..
	}
	search
elif [ "$var" = "d" ] || [ "$var" = "D" ] || [ "$var" = "directory" ] || [ "$var" = "DIRECTORY" ]
then
	echo "Directory ?"
	read dir
	search()
	{
		for list in `ls`
		do
			if [ -d "$list" ]
			then
				if [[ $list == *$dir* ]]
				then
					echo "Directory $list is in `pwd`" 
				fi
				cd $list
				search
			fi
		done
		cd ..
	}
	search
else
		echo "!!! Error : wrong command !!!"
fi

cd -
