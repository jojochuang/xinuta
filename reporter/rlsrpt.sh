#!/bin/bash

if [ $# -lt 4 ]; then
        echo "Usage :rlsrpt uid labno src dest"
        exit 1
fi

uid=$1
labno=$2
src=$3
dest=$4

# grant execute access to the outmost directory for uid
setfacl -m u:$uid:x $dest
# grant read and execute access to the outmost directory
# 	for Prof. Park
setfacl -m u:park:rx $dest
setfacl -m u:chuangw:rwx $dest
setfacl -m u:ko16:rwx $dest
setfacl -m u:nduong:rwx $dest

# if the student's directory doesn't exist, then create it
if [ ! -d $dest$uid ]; then
	mkdir $dest$uid -m 700
# grant read and execute access to the student's directory
# 	for a particular student
	setfacl -m u:$uid:rx $dest$uid
# grant read and execute access to the student's directory
# 	for Prof. Park
	setfacl -m u:park:rx $dest$uid
	setfacl -m u:chuangw:rwx $dest$uid
  setfacl -m u:ko16:rwx $dest$uid
  setfacl -m u:nduong:rwx $dest$uid
fi

# copy the report and grant read access
cp $src$uid/$labno.rpt $dest$uid/$labno.rpt
chmod 600 $dest$uid/$labno.rpt
setfacl -m u:$uid:r $dest$uid/$labno.rpt
setfacl -m u:park:r $dest$uid/$labno.rpt
setfacl -m u:chuangw:rw $dest$uid/$labno.rpt
setfacl -m u:ko16:rw $dest$uid/$labno.rpt
setfacl -m u:nduong:rw $dest$uid/$labno.rpt
