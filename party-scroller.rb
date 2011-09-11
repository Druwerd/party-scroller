#!/usr/bin/ruby

require 'rubygems'
require 'sinatra'
require 'erb'
require 'text_message.rb'

SETTINGS = YAML.load_file('config.yml')
PHONE_NUMBER = SETTINGS["google-voice"]["phone_number"]

set :root, File.dirname(__FILE__)

get '/' do
  @refresh_rate = 30
  @info = "Text your message to #{PHONE_NUMBER} to display it here!"
  @message = @info
  textmessage = TextMessage.all(:read => false).first
  textmessage = TextMessage.all.last if textmessage.nil?
  
  unless textmessage.nil?
    @message = textmessage.body
    textmessage.update(:read => true)
  end
  
  @message = @message.gsub("\n", " ")
  puts @message
  erb :index
end