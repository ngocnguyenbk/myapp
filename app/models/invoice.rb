class Invoice < ApplicationRecord
  include SoftDeletable

  has_one :item_electric, class_name: Item::Electric.name
  has_one :item_internet, class_name: Item::Internet.name
  has_one :item_parking_fee, class_name: Item::ParkingFee.name
  has_one :item_service, class_name: Item::Service.name
  has_one :item_water, class_name: Item::Water.name

  has_many :item_electrics, class_name: Item::Electric.name
  has_many :item_internets, class_name: Item::Internet.name
  has_many :item_parking_fees, class_name: Item::ParkingFee.name
  has_many :item_services, class_name: Item::Service.name
  has_many :item_waters, class_name: Item::Water.name

  belongs_to :contract

  scope :month_ago, -> { where(date_export: 1.month.ago.beginning_of_month..1.month.ago.end_of_month) }
  scope :ordered, -> { includes(contract: :room).order(date_export: :DESC).order("rooms.room_number ASC") }
  scope :in_month, ->(month) { where(date_export: month.to_date.beginning_of_month..month.to_date.end_of_month)}
end
