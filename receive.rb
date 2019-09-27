#!/usr/bin/env ruby
require "rubygems"
require 'bunny'
require 'json'
require 'pp'
require 'mongo'

connection = Bunny.new
connection.start

channel = connection.create_channel
queue = channel.queue('json_send_file')
begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    obj = JSON.parse(body)
    puts " [--] Read JSON in prepare to send to mongo db"
    Mongo::Logger.logger.level = Logger::WARN
    co = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'test')
    cols_test = co.database.collection("test")
    cols_test.insert_one(obj)
    puts " [::] Save Your JSON in mongo db"
  end
rescue Interrupt => _
  connection.close

  exit(0)
end
