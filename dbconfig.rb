require 'rubygems'
require 'data_mapper'
require 'logger'
### DB SETUP ###

DB_PATH = '/Users/drew/Downloads/party-scroller/db/scroller.db'

DataMapper.setup(:default, "sqlite3://#{DB_PATH}")