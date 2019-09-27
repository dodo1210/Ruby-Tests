#!/usr/bin/env ruby
require "rubygems"
require 'bunny'



json = File.read('file.json')
connection =Bunny.new(host:  'localhost',
                 port:  '5672',
                 vhost: '/',
                 user:  'guest',
                 pass:  'guest')
connection.start
channel = connection.create_channel
queue = channel.queue('json_send_file')
channel.default_exchange.publish(json, routing_key: queue.name)
puts " [x] Sent 'Hello World!'"
connection.close
