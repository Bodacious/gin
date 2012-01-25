class Apple < ActiveRecord::Base
  attr_accessor :name
  has_many :chickens
end
