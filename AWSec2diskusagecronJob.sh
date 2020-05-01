#!/bin/bash
#This script checks the disk space used on the ec2.

chk_size() {

        df1=$(df -h|sed -n '1p')
        df2=$(df -h|sed -n '4p')
        diskusage=$(df -h|sed -n '4p'|awk '{print $4}'|cut -c 1-2)  #Will disply the available disk space in a sigle digit

        if [ $diskusage -lt 10 ]
        then
        {
        mail -r <mailid> -s "EMEREGENCY DISK USAGE CRITICAL for AWS Server"  <MailID><<BODY
The Current Disk usage is as follows:
$df1
$df2
BODY

        }
        else
        {
                  mail -r MXA.mailman@XXX.com -s "WEEKLY DISK USAGE Report for AWS Server"  mxaadmins@xxx.com<<BODY
The Current Disk usage is as follows:
$df1
$df2
BODY
        }
fi
}
chk_size
