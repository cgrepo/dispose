class Vehicle < ActiveRecord::Base
  belongs_to :concessionary
  has_one :debt
end
