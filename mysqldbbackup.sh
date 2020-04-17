
#this code is taking backup of the application DB and send a copy to the s3 bucket, then will send out an email notification


#!/bin/bash
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
location=/root/alan/DBBACKUP/hrms-`date +%F`.sql
mysqldump -u user --password='xxx' DBname  > $location
code=$?

if [[ $code -eq 0 ]]; then
gzip $location
code=$?
fi

if [[ -e "${location}.gz" ]] && [[ $code -eq 0 ]]; then
aws s3 cp $location.gz  s3://backups3katzion
#scp $location  root@10.1.0.12:/raid/hrms-backup
code=$?
echo "AWS totus DB backup sucess" | mail  -s "Totus backup sucess: backup generated sucess"  alan.jose@katzion.com,riyas.perumpulliyil@katzion.com
fi

if [[ $code -ne 0 ]]; then
echo "AWS Totus DB backup failed" | mail  -s "Totus backup failed: Check 'backups3katzion S3' for more details"  XXX@katzion.com,XXX@katzion.com
fi
#For email configuration please see in /etc/mail.rc   ### mailx
