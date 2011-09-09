#!/usr/bin/ruby

require 'rubygems'
require 'gmail'
require 'text_message.rb'

LOGIN = "user"
PASSWORD = "password"
GOOGLEVOICE_RETURN_ADDRESS = "XXXXXXXXXXX.XXXXXXXXXXX.txsrD45xqM@txt.voice.google.com"

Gmail.new(LOGIN, PASSWORD) do |gmail|
  # ...do things...
  #gmail.peek = true
  messages = gmail.inbox.emails(:unread, :from => GOOGLEVOICE_RETURN_ADDRESS)
  puts messages
  messages.each do |message|
    puts message.body
    @text_message = TextMessage.create(
      :body => message.body,
      :created_at => Time.now,
      :read => false
    )
  end
end