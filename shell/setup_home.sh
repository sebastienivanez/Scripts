#! /usr/bin/env bash

echo "Deal with reports ? (y/n) "
read var_reports
if [ "$var_reports" = "y" ] || [ "$var_reports" = "yes" ]
then
	echo "Info: Dealing with reports repository"
	if [ -d ~/reports ]
	then
		mkdir ~/reports_fmr
		cp ~/reports/d* ~/reports_fmr
		cp ~/reports/o* ~/reports_fmr
		cp ~/reports/i* ~/reports_fmr
		rm -rf ~/reports
		mv ~/reports_fmr ~/reports
	else
		echo "Warning: No reports repository"
	fi
elif [ "$var_reports" = "n" ] || [ "$var_reports" = "no" ]
then
	echo "Info: Doing nothing"
else
	echo "Error: Wrong command (y/n)"
fi

echo "Deal with bashrc ? (y/n) "
read var_bashrc
if [ "$var_bashrc" = "y" ] || [ "$var_bashrc" = "yes" ]
then
	echo "Info: Dealing with bashrc"
	if [ -f ~/.bashrc ]
	then
		mv ~/.bashrc ~/.bashrc_old
		#touch ~/.bashrc
		ln -s ../my_bashrc ~/.bashrc
	else
		echo "Warning: No file .bashrc in home"
	fi
elif [ "$var_bashrc" = "n" ] || [ "$var_bashrc" = "no" ]
then
	echo "Info: Doing nothing"
else
	echo "Error: Wrong command (y/n)"
fi
