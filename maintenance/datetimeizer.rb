require 'mongoid'
require_relative "../model"

Mongoid.configure do |config|
  name = "sleeplogger"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
  Mongo::Connection.new(host, 27017).db(name)
  config.persist_in_safe_mode = false
end

results = Sleep.all

sleeps = []
results.each do |entry|
  sleeps << {name: entry[:name], datetime:  DateTime.parse(entry[:time])}
  entry.delete
end

sleeps.each do |sleep|
  Sleep.new(sleep).save
end