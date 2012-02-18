#encoding: utf-8
require 'cuba'
require 'mongoid'

require_relative 'model'
require_relative 'sleeps'

#Cuba.use Rack::Session::Cookie

#ROOT_PATH = File.expand_path(File.dirname(__FILE__))
#Cuba.use Rack::Static, urls: [""], root: File.join(ROOT_PATH, "public")

#Cuba.use Rack::Static, :urls => ["/viewmodels", "/libs"], :root => File.join(ROOT_PATH, 'public')

Mongoid.configure do |config|
  name = "sleeplogger"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
  Mongo::Connection.new(host, 27017).db(name)
  config.persist_in_safe_mode = false
end

def add_sleep(name)
  sleep = Sleep.new
  sleep.update_attributes(:name => name, :time => Time.now)
  sleep.save
end

def return_sleeps()
  results = Sleep.all.entries
  return Sleeps.new(results).sleeps
end

def return_sleeps_for(name)
  results = Sleep.all(conditions: { name: name }).entries
	return Sleeps.new(results).sleeps
end

def return_last_sleep()
  result = Sleep.last
	return Sleeps.new(result).sleeps
end

def return_last_sleep_for(name)
  result = Sleep.last(conditions: { name: name })
	return Sleeps.new(result).sleeps
end

def json_encode(data)
	ActiveSupport::JSON.encode(data)
end

Cuba.define do
  on get do
		on "sleep" do
			on ":user_name" do |user_name|
				on "times" do
					# on "last" do
						# res.write json_encode(return_last_sleep)
					# end
					res.write json_encode(return_sleeps_for(user_name.capitalize))
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
					add_sleep(user_name.capitalize)
					res.write json_encode(return_sleeps_for(user_name.capitalize)) 
				end
			end
		end
  end
end
