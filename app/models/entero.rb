class Entero < ActiveRecord::Base
    belongs_to :concessionary
    # HUMANIZED_ATTRIBUTES = {taxpayer:'concessionario', service:'servicio', quantity:'cantidad', unit:'unidad'}
    # validates :taxpayer, :service, :unit, :quantity, presence: { message: 'No puede estar en blanco'}

    # def self.human_attribute_name(attr, options = {})
    #     HUMANIZED_ATTRIBUTES[attr.to_sym] || super
    # end
end
