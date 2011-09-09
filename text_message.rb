require 'dbconfig.rb'

class TextMessage #< DataMapper::Base
    include DataMapper::Resource
    
    property :id, Serial
    property :body, Text
    property :created_at, DateTime
    property :read, Boolean
end

unless File.exists?(DB_PATH)
  DataMapper.auto_migrate!
end