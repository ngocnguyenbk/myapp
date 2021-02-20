class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :room_number, :month, :room_price, :total_electric, :total_water, :total_internet, :total_parking_fee,
             :total_service, :reduce, :total

  def room_number
    object.contract.room.room_number
  end

  def month
    object.date_export.strftime("%-m/%Y")
  end

  def room_price
    object.contract.room_price
  end

  def total_electric
    object.item_electric.total
  end

  def total_water
    object.item_water.total
  end

  def total_internet
    object.item_internet.total
  end

  def total_parking_fee
    object.item_parking_fee.total
  end

  def total_service
    object.item_service.total
  end
end
