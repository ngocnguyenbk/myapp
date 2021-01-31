class Invoice < ApplicationRecord
  has_many :item_electrics, class_name: Item::Electric.name
  has_many :item_internets, class_name: Item::Internet.name
  has_many :item_parking_fees, class_name: Item::ParkingFee.name
  has_many :item_services, class_name: Item::Service.name
  has_many :item_waters, class_name: Item::Water.name

  belongs_to :contract
end
