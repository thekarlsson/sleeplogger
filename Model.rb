require 'mongoid'

class Sleep
  include Mongoid::Document
  field :name, type: String
  field :datetime, type: DateTime
end