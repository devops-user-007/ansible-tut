#!/bin/bash

backup_date='date +%Y_%m_%d_%H_%M'
backup_parent_dir="/var/backups/mysql"
#mysql -u root -proot employee_db > employee_db.sql


# MySQL settings
mysql_user="root"
mysql_password=""


# Read MySQL password from stdin if empty
if [ -z "${mysql_password}" ]; then
  echo -n "Enter MySQL password for ${mysql_user} user : "
  read -s mysql_password
  echo
fi


# Create backup directory and set permissions
backup_date='date +%Y_%m_%d_%H_%M'
backup_dir="${backup_parent_dir}/${backup_date}"
echo "Backup directory: ${backup_dir}"
mkdir -p "${backup_dir}"
chmod 700 "${backup_dir}"


# Check MySQL password
echo exit | mysql --user=${mysql_user} --password=${mysql_password} -B 2>/dev/null
if [ "$?" -gt 0 ]; then
  echo "MySQL ${mysql_user} password incorrect"
  exit 1
else
  echo "MySQL ${mysql_user} password correct."
fi


# Get MySQL databases
mysql_databases="echo 'show databases' | mysql --user=${mysql_user} --password=${mysql_password} -B | sed /^Database$/d"

