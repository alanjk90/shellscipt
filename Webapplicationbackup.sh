#!/bin/bash

cd /root/BACKUP/BACKUPS;

foldercount=$(ls -l|wc -l);

rm -rf /root/BACKUP/BACKUPS/*

let "foldercount=foldercount-1"

if [ $foldercount -gt 1 ]

then
        delfolder=$(ls | sort | head -1);

        rm -rf $delfolder;

        backupdate=$(date +"%Y-%m-%d");

        mkdir $backupdate;

        cd $backupdate;

        mkdir ETC;

        cd ETC;

        cp -rp /etc/lighttpd/ .;  #taking full backup for /etc/lighttpd

        cp -rp /etc/php/ .;     #taking full backup of /etc/php

        cp -rp /etc/mysql/ .;    #taking full backupof /etc/mysql 

        cd ../;

        mkdir WWW;

        cd WWW;

        cp -rp /var/www/ .;

        cd ../;

        mkdir SSL;

        cd SSL;

        cp -rp /root/ssl/ .;  #taking ssl config backup   

        cd ../;

        mkdir MYSQL_DUMPS;

        cd MYSQL_DUMPS;

        cpulimit -l 50 mysqldump mysql > mysql.sql;


        cd ./;


else

        backupdate=$(date +"%Y-%m-%d");

        mkdir $backupdate;

        cd $backupdate;

        mkdir ETC;

        cd ETC;

        cp -rp /etc/lighttpd/ .;

        cp -rp /etc/php/ .;

        cp -rp /etc/mysql/ .;

        cd ../;

        mkdir WWW;

        cd WWW;

        cp -rp /var/www/ .;

        cd ../;

        mkdir SSL;

        cd SSL;

        cp -rp /root/ssl.;

        cd ../;

        mkdir MYSQL_DUMPS;

        cd MYSQL_DUMPS;

        cpulimit -l 50 mysqldump mysql > mysql.sql;

        cd ./;

fi
