class Invoice < ApplicationRecord
  has_one :item_electrics, class_name: Item::Electric.name
  has_one :item_internets, class_name: Item::Internet.name
  has_one :item_parking_fees, class_name: Item::ParkingFee.name
  has_one :item_services, class_name: Item::Service.name
  has_one :item_waters, class_name: Item::Water.name

  belongs_to :contract

  scope :month_ago, -> { where(date_export: 1.month.ago.beginning_of_month..1.month.ago.end_of_month) }
end
