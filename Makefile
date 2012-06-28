default: backup cleanup

backup:
	./backup.sh jsik:www jsikweb
	./backup.sh next-l:www nextlweb
	./backup.sh code4libjp:www c4ljpweb 
	./backup.sh etk:www/stim stimweb
	./backup.sh etk2:www/cres cresweb

cleanup:
	./cleanup.rb
