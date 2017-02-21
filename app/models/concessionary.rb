class Concessionary < ActiveRecord::Base
    has_many :vehicles
    has_many :Enteros
end
