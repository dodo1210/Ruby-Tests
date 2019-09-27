#!/usr/bin/env ruby
require "rubygems"
require 'json'
require 'pp'
require 'mongo'

Mongo::Logger.logger.level = Logger::WARN
co = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'test')
cols_test = co.database.collection("test")
cols_test.find().each do |doc|
  pp doc
  pp doc.keys
  pp doc["uri"]
end
