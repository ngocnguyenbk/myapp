class ServiceItem < ApplicationRecord
  include SoftDeletable

  belongs_to :invoice

  scope :internets, -> { where(type: "Item::Internet") }
  scope :parking_fees, -> { where(type: "Item::ParkingFee") }
  scope :services, -> { where(type: "Item::Service") }

  def self.type
    %w[Item::Internet Item::ParkingFee Item::Service]
  end

  def x_unit
    I18n.t(".unit.#{unit}")
  end
end
