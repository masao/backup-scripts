#!/bin/sh

logfile=log-`date +%Y%m%d`
backupdir=/project/backup

export PATH="/usr/local/bin:$PATH"

for dir in /home/masao /home/yuka /etc; do
    pdumpfs $dir $backupdir >> $backupdir/$logfile
done

bzip2 -9 $backupdir/$logfile

hlbackup-clean $backupdir
