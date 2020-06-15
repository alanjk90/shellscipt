#!/bin/bash


if [ $# -eq 0 ]
then
        echo "Username not supplied"
        exit
fi

username=$1

useradd -d /ftpstorage/$username -s /usr/sbin/nologin $username

password=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13`
echo "$username:$password" | chpasswd

echo $password

mkdir /ftpstorage/$username

mkdir /ftpstorage/$username/$username

chown $username.$username /ftpstorage/$username/$username
chmod  2775 /ftpstorage/$username/$username

usermod -a -G $username ftpadmin

cp -a /etc/ssh/sshd_config /root

cat >> /etc/ssh/sshd_config <<End-of-message

Match User $username
  PasswordAuthentication yes
  X11Forwarding no
  AllowTcpForwarding no
  ChrootDirectory /ftpstorage/$username
  ForceCommand internal-sftp


End-of-message



service ssh restart
/etc/init.d/ssh restart
