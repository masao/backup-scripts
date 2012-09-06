BACKUP_DIR=/project/backup
SAVEMLAK_BACKUP_OLD=`date -d '-3days' +'%Y%m%d180[01].sql.bz2'`
SAVEMLAK_BACKUP=`date -d '-2days' +'%Y%m%d180[01].sql.bz2'`

default: backup cleanup

backup:
	./backup.sh jsik:www jsikweb
	./backup.sh next-l:www nextlweb
	./backup.sh "code4libjp:{www,backup}" c4ljpweb 
	./backup.sh etk:www/stim stimweb
	./backup.sh etk2:www/cres cresweb
	./backup.sh "savemlak.jp:{/media/savemlak/backup/$(SAVEMLAK_BACKUP),/var/www/html}" savemlakweb
	-rm -f $(BACKUP_DIR)/savemlakweb/$(SAVEMLAK_BACKUP_OLD)

cleanup:
	./cleanup.rb
