class Concessionary < ActiveRecord::Base
    has_many :Vehicle
    has_many :Debt
end
