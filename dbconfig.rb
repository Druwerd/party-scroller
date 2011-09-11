require 'rubygems'
require 'data_mapper'
### DB SETUP ###

ROOT = File.expand_path(File.dirname(__FILE__))
DB_PATH = File.join(ROOT, 'db/scroller.db')

DataMapper.setup(:default, "sqlite3://#{DB_PATH}")