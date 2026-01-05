#!/usr/bin/env bash
#
#Add bulk users from a file in a list form

LOG_FILE="user_creation.log"
USER_FILE="user.txt"

#check for root privelages

if [[ $EUID -ne 0 ]]
then
	echo "use root privilages to run script"
	exit 1
fi

while IFS=read -r user
do
	[ -z "user" ] $$ continue


	#check if user exists
	if id "$user" &>/dev/null
	then
		echo "[$(date)] $user already exists,skipping" | tee -a "LOG_FILE"
		continue
	fi

	#create user
	if sudo adduser --disabled-password --gecos "" "$user"
	then
		echo "[$(date)] $user created successfully" | tee -a "LOG_FILE"
		continue 
	fi
done<"$USER_FILE"
echo "==user creation completed successfully== $(date)" | tee -a "LOG_FILE"
