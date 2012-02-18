require 'mongoid'

class Sleep
  include Mongoid::Document
  field :name, type: String
  field :time, type: String
end