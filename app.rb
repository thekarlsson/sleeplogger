#encoding: utf-8
require 'cuba'
require 'mongoid'

require_relative 'model'

Mongoid.configure do |config|
  name = "sleeploggerdev1"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
  Mongo::Connection.new(host, 27017).db(name)
  config.persist_in_safe_mode = false
end

Cuba.define do
  on get do
		on "sleep" do
			on ":user_name" do |user_name|
				on "times" do
					res.write ActiveSupport::JSON.encode(Sleep.all(conditions: { name: user_name.capitalize }).entries)
				end
				res.write File.read(File.join('public', 'app.html'))
			end
		end

		on ":whatever" do |whatever|
			res.write "GOTO <a href=\"sleep/#{whatever}\">sleep/#{whatever}</a>, comrade!"
		end
  end
  
  on post do
		on "sleep" do
			on ":user_name" do |user_name|
				on "sleepnow" do
          sleep = Sleep.new(name: user_name.capitalize, datetime: DateTime.now).save
					res.write ActiveSupport::JSON.encode(Sleep.all(conditions: { name: user_name.capitalize }).entries) 
				end
			end
		end
  end
end
