class Vehicle < ActiveRecord::Base
  belongs_to :concessionary
  has_many :debts
end
