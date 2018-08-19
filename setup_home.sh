#! /usr/bin/env bash

SCRIPTS_PATH=~/Scripts
REPORTS_PATH=~/Scripts/reports

echo "Deal with reports ? (y/n) "
read var_reports
if [ "$var_reports" = "y" ] || [ "$var_reports" = "yes" ]
then
	echo "Info: Dealing with reports repository"
	if [ -d $REPORTS_PATH ]
	then
		mkdir ~/Reports
		cp $REPORTS_PATH/d* ~/Reports
		cp $REPORTS_PATH/o* ~/Reports
		cp $REPORTS_PATH/i* ~/Reports
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
		cp $SCRIPTS_PATH/my_bashrc ~/.bashrc
		source ~/.bashrc
	else
		echo "Warning: No file .bashrc in home"
	fi
elif [ "$var_bashrc" = "n" ] || [ "$var_bashrc" = "no" ]
then
	echo "Info: Doing nothing"
else
	echo "Error: Wrong command (y/n)"
fi
