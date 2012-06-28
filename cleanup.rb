#!/usr/bin/env ruby
# $Id$

require "fileutils"
require "date"

BACKUP_DIR = "/project/backup"
DEFAULT_KEEP_SPEC_S = "10y6m7d"
DEFAULT_KEEP_SPEC   = {
   :year => 10,
   :month => 6,
   :day => 7,
}

if $0 == __FILE__
   d = Date.today
   keep_spec = DEFAULT_KEEP_SPEC
   keep = []
   keep_spec.each do |spec, val|
      case spec
      when :year
         val.times do |i|
            keep << Date.new( d.year - i, 1, 1 ).strftime( "%Y%m%d" )
         end
      when :month
         y = d.year
         m = d.month
         keep << Date.new( y, m, 1 ).strftime( "%Y%m%d" )
         ( val - 1 ).times do |i|
            if m > 1
               m = m - 1
            else
               y = y - 1
               m = 12
            end
            keep << Date.new( y, m, 1 ).strftime( "%Y%m%d" )
         end
      when :day
         val.times do |i|
            d2 = d - i
            keep << Date.new( d2.year, d2.month, d2.day ).strftime( "%Y%m%d" )
         end
      else
         raise "unknown spec: #{ spec }"
      end
   end
   # p keep.sort
   Dir.glob( "#{ BACKUP_DIR }/*.tar.bz2" ) do |file|
      if file =~ /(\d+)\.tar\.bz2\Z/o
         ymd = $1
         if keep.include? ymd
            STDERR.puts "keep #{ file }." if $DEBUG
         else
            STDERR.puts "delete #{ file }." if $DEBUG
            FileUtils.rm( file, :verbose => true )
         end
      else
         raise "unknown suffix format for backup file: #{ file }"
      end
   end
end
