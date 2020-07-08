#!/bin/bash
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
src=/data/www/XXX
dest=/root/alan/XXX
pkg_name=XXX-`date +%F`
backup_count=4
[[ ! -d $src ]] && exit 255
mkdir -p $dest
tar -czf $dest/${pkg_name}.tar.gz -C /data/www/ html
size=$(du -hsm $dest/${pkg_name}.tar.gz | awk '{print $1}')
if [[ $? -eq 0 ]] && [[ $size -gt 10 ]];then
echo "success"
find $dest -type f -iname *.gz -mtime +${backup_count} -delete
else
echo "failed"
rm -rf $dest/${pkg_name}.tar.gz
fi

