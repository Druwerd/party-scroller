#!/usr/bin/ruby

require 'rubygems'
require 'gmail'
require 'text_message.rb'

LOGIN = "user"
PASSWORD = "password"
GOOGLEVOICE_RETURN_ADDRESS = "XXXXXXXXXXX.XXXXXXXXXXX.txsrD45xqM@txt.voice.google.com"
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