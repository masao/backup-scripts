#!/bin/sh

TARGET=$1
BACKUP_NAME=$2

BACKUP_DIR=/project/backup
TMP_DIR=/project/backup
BACKUP_TMPDIR=$TMP_DIR/$BACKUP_NAME
TIMESTAMP=`date +%Y%m%d`
BACKUP_FILE=$BACKUP_NAME-$TIMESTAMP.tar.bz2

BASEDIR=$PWD
cd $TMP_DIR
$BASEDIR/rsync.pl -avz --delete-before --exclude=download/vm/ $TARGET $BACKUP_TMPDIR

cd `dirname $BACKUP_TMPDIR`
if [ -f $BACKUP_FILE ]; then
    rm -f $BACKUP_FILE
fi
tar jcf $BACKUP_FILE $BACKUP_NAME
chmod a-w $BACKUP_FILE
if [ $BACKUP_DIR != $TMP_DIR ]; then
    mv -f $BACKUP_FILE $BACKUP_DIR
fi
