#!/bin/bash
 
export PATH=/bin:/usr/bin:/usr/local/bin
TODAY='date +"%d%b%Y"'
 
## SET VARIABLES
 
BACKUPPATH='/var/backup'
MYSQL_HOST='192.168.10.7'
MYSQL_PORT='3306'
MYSQL_USER='root'
MYSQL_PASSWORD='root'
DATABASE_NAME='employee_db'
BACKUPRETAINDAYS=15   ## Number of days to keep local backup copy
 
#################################################################
 
mkdir -p ${BACKUPPATH}/${TODAY}
echo "Backup started for database - ${DATABASE_NAME}"

 
mysqldump -h ${MYSQL_HOST} \
   -P ${MYSQL_PORT} \
   -u ${MYSQL_USER} \
   -p${MYSQL_PASSWORD} \
   ${DATABASE_NAME} | gzip > ${BACKUPPATH}/${TODAY}/${DATABASE_NAME}-${TODAY}.sql.gz
 
if [ $? -eq 0 ]; then
  echo "Database backup successfully completed"
else
  echo "Error found during backup"
fi
 
 
## Remove backups older than {BACKUPRETAINDAYS} days
 
DBDELDATE='date +"%d%b%Y" --date="${DBRETAINDAYS} days ago"'
 
rm -rf ${BACKUPPATH}/${DBDELDATE}

