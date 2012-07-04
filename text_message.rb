require './dbconfig.rb'

class TextMessage #< DataMapper::Base
    include DataMapper::Resource
    
    property :id, Serial, :required => true
    property :body, Text, :required => true
    property :created_at, DateTime, :required => true
    property :read, Boolean, :required => true
end

unless File.exists?(DB_PATH)
  DataMapper.auto_migrate!
end

DataMapper.finalize