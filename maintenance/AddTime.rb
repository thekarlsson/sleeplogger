require 'mongoid'

require_relative '../model'

def connect()
  Mongoid.configure do |config|
    name = "sleeplogger"
    host = "localhost"
    config.master = Mongo::Connection.new.db(name)
    Mongo::Connection.new(host, 27017).db(name)
    config.persist_in_safe_mode = false
  end  
end

def add_time(username, datetime)
  Sleep.new(name: username.capitalize, datetime: datetime).save
end

def main(username, datetime)
  connect
  
  add_time(username, datetime)
end

if __FILE__ == $0
  main("Pablo", DateTime.parse('10th Mar 2012 22:15:00+01:00'))
end