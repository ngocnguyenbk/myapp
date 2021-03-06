class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :room_number, :month, :room_price, :total_electric, :total_water, :total_internet, :total_parking_fee,
             :total_service, :reduce, :total, :month_ago, :qty_electric, :qty_water, :qty_internet, :qty_parking_fee,
             :qty_service, :unit_electric, :unit_water, :unit_internet, :unit_parking_fee, :unit_service, :unit_price_electric,
             :unit_price_water, :unit_price_internet, :unit_price_parking_fee, :unit_price_service, :begin_number_ele,
             :end_number_ele, :begin_number_wat, :end_number_wat, :total_cost, :total_reduce, :total_revenue

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

  def total_cost
    object.total
  end

  def total_reduce
    object.reduce
  end

  def total_revenue
    total_cost - total_reduce
  end

  def month_ago
    (object.date_export - 1.month).month
  end

  def qty_electric
    object.item_electric.quantity
  end

  def qty_water
    object.item_water.quantity
  end

  def qty_internet
    object.item_internet.quantity
  end

  def qty_parking_fee
    object.item_parking_fee.quantity
  end

  def qty_service
    object.item_service.quantity
  end

  def unit_electric
    object.item_electric.x_unit
  end

  def unit_water
    object.item_water.x_unit
  end

  def unit_internet
    object.item_internet.x_unit
  end

  def unit_parking_fee
    object.item_parking_fee.x_unit
  end

  def unit_service
    object.item_service.x_unit
  end

  def unit_price_electric
    object.item_electric.unit_price
  end

  def unit_price_water
    object.item_water.unit_price
  end

  def unit_price_internet
    object.item_internet.unit_price
  end

  def unit_price_parking_fee
    object.item_parking_fee.unit_price
  end

  def unit_price_service
    object.item_service.unit_price
  end

  def begin_number_ele
    object.item_electric.begin_number
  end

  def end_number_ele
    object.item_electric.end_number
  end

  def begin_number_wat
    object.item_water.begin_number
  end

  def end_number_wat
    object.item_water.end_number
  end
end
