#!/bin/bash
HOST=192.168.1.117
USER=herc01
PASSWORD=CUL8TR

ftp -inv $HOST 2100  <<EOF
user $USER $PASSWORD
cd herc01.test.seqdata
put TEACHER.DAT TEACHER
bye
EOF