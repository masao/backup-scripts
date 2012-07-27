SAVEMLAK_BACKUP=`date -d yesterday +'%Y%m%d1800.sql.bz2'`

default: backup cleanup

backup:
	./backup.sh "savemlak.jp:{/media/savemlak/backup/$(SAVEMLAK_BACKUP),/var/www/html}" savemlakweb
	./backup.sh jsik:www jsikweb
	./backup.sh next-l:www nextlweb
	./backup.sh "code4libjp:{www,backup}" c4ljpweb 
	./backup.sh etk:www/stim stimweb
	./backup.sh etk2:www/cres cresweb

cleanup:
	./cleanup.rb
