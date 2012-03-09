#encoding: utf-8
require 'cuba'
require 'mongoid'

require_relative 'model'

Mongoid.configure do |config|
  name = "sleeplogger"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
  Mongo::Connection.new(host, 27017).db(name)
  config.persist_in_safe_mode = false
end

def return_sleeps(username, amount)
  res.write ActiveSupport::JSON.encode(sleeps = Sleep.desc(:datetime).all_of(name: username.capitalize).limit(amount))
end

Cuba.define do
  on get do
		on "sleep" do
			on ":username" do |username|
				on "times" do
					on ":number_of_times_to_return" do |number_of|
					  return_sleeps(username.capitalize, number_of.to_i)
					end
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
			on ":username" do |username|
				on "sleepnow", param('numberOfTimes') do |number_of|
          sleep = Sleep.new(name: username.capitalize, datetime: DateTime.now).save
          return_sleeps(username.capitalize, number_of.to_i)
				end
			end
		end
  end
end
