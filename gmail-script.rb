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
      next if message.nil? or message.from.nil? or message.from.first['host'].nil?
      next if message.from.first['host'] != "txt.voice.google.com"
      next if message.body.nil?
      puts message
      sms_text = message.body.to_s.gsub("\n", " ")
      sms_text = sms_text.gsub(/[^\w!\.,\?\-:\(\)]/, "?")
      sms_text = sms_text.gsub(/Sent using SMS-to-email.*/, "")
      puts sms_text
      begin
        @text_message = TextMessage.create(
          :body => sms_text,
          :created_at => Time.now,
          :read => false
        )
      rescue => e
        puts e
      end
    end
    sleep(FREQUENCY)
  end
end