#!/usr/bin/ruby

require 'rubygems'
require 'gmail'
require 'yaml'
require 'text_message.rb'

SETTINGS = YAML.load_file('config.yml')
LOGIN = SETTINGS["gmail"]["login"]
PASSWORD = SETTINGS["gmail"]["password"]
GOOGLEVOICE_RETURN_ADDRESS = SETTINGS["gmail"]["return_address"]

FREQUENCY = 5 # How often (in seconds) to check for new messages

Gmail.new(LOGIN, PASSWORD) do |gmail|
  while true
    messages = gmail.inbox.emails(:unread, :from => GOOGLEVOICE_RETURN_ADDRESS)
    messages.each do |message|
      puts messages
      puts message.body
      @text_message = TextMessage.create(
        :body => message.body,
        :created_at => Time.now,
        :read => false
      )
    end
    sleep(FREQUENCY)
  end
end