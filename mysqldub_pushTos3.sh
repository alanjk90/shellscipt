#!/bin/bash
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
location=/root/alan/XXX/XXX-`date +%F`.sql
mysqldump -u username --password='XXXX' DBname  > $location
code=$?

if [[ $code -eq 0 ]]; then
gzip $location
code=$?
fi

if [[ -e "${location}.gz" ]] && [[ $code -eq 0 ]]; then
aws s3 cp $location.gz  s3://s3name
code=$?
echo "AWS totus DB backup sucess" | mail  -s "Totus backup sucess: backup generated sucess"  emailids,emailids2
fi

if [[ $code -ne 0 ]]; then
echo "AWS Totus DB backup failed" | mail  -s "Totus backup failed: Check 'backups3katzion S3' for more details"  maild1,mailid2
fi

dest=/root/alan/DBBACKUP
backup_count=4
find $dest -type f -iname *.gz -mtime +${backup_count} -delete
#For email configuration please see in /etc/mail.rc   ### mailx

