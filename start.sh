#!/bin/bash

# Requires Ruby 1.8.7 installed using rvm
#rvm use ruby-1.8.7

ruby party-scroller.rb >> party-scroller-web.log 2>&1 &
ruby gmail-script.rb >> gmail-script.log 2>&1 &