#!/usr/bin/env ruby
# $Id$

require "yaml"

conf = open( "mysqldump.conf" ){|io| YAML.load( io ) }

backup_file = File.join( conf[ "BACKUP_DIR" ], "mysqldump.txt" )

system( "mysqldump -q --host=#{ conf[ "MYSQL_HOST" ] } --user=#{ conf[ "MYSQL_USER" ] --password=#{ conf[ "MYSQL_PASSWORD" ] } #{ conf[ "MYSQL_DBNAME" ] } > #{ backup_file }" )
