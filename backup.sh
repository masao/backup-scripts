#!/bin/sh

TARGET=$1
BACKUP_NAME=$2

BACKUP_DIR=/project/backup
TMP_DIR=/tmp
BACKUP_TMPDIR=$TMP_DIR/$BACKUP_NAME
TIMESTAMP=`date +%Y%m%d`
BACKUP_FILE=$BACKUP_NAME-$TIMESTAMP.tar.bz2

cd $TMP_DIR
rsync -avz --delete-before --exclude=download/vm/ $TARGET $BACKUP_TMPDIR

cd `dirname $BACKUP_TMPDIR`
tar jcf $BACKUP_FILE $BACKUP_NAME
chmod a-w $BACKUP_FILE
mv -f $BACKUP_FILE $BACKUP_DIR
