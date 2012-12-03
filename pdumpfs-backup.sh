#!/bin/sh

logfile=log-`date +%Y%m%d`
backupdir=/project/backup

export PATH="/usr/local/bin:$PATH"

# 偶数日にのみ実行する
day=`date +%-d`
if [ "$day" -eq 1 -o `echo "$day % 2" | bc` -eq 0 ]; then
  exit 0
fi

for dir in /home/masao /home/yuka /etc; do
    pdumpfs $dir $backupdir >> $backupdir/$logfile
done

bzip2 -9 $backupdir/$logfile

hlbackup-clean $backupdir
