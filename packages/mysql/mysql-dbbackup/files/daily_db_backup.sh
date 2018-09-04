#!/bin/bash
NOW=$(date +"%m-%d-%Y")
echo $NOW

mysqldump employee_db > employee_db_$NOW.sql
scp /opt/scripts/employee_db_$NOW.sql root@192.168.10.7:/opt

