#!/usr/bin/ruby

require 'rubygems'
require 'gmail'
require 'yaml'
require 'text_message.rb'

SETTINGS = YAML.load_file('config.yml')
LOGIN = SETTINGS["gmail"]["login"]
PASSWORD = SETTINGS["gmail"]["password"]

FREQUENCY = 5 # How often (in seconds) to check for new messages

Gmail.new(LOGIN, PASSWORD) do |gmail|
  while true
    messages = gmail.inbox.emails(:unread)
    messages.each do |message|
      next unless message.from.first['host'] == "txt.voice.google.com"
      puts message
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