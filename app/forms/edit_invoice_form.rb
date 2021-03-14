class EditInvoiceForm < BaseForm
  attribute :room_price, Integer
  attribute :day_used_per_month, Integer
  attribute :electric_start, Integer
  attribute :electric_end, Integer
  attribute :water_start, Integer
  attribute :water_end, Integer
  attribute :unit_price_internet, Integer
  attribute :unit_price_parking_fee, Integer
  attribute :quantity_parking, Integer
  attribute :unit_price_service_fee, Integer
  attribute :reduce, Integer
  attribute :total, Integer
  attribute :step, String

  validates :room_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :electric_start, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :electric_end, presence: true, numericality: { greater_than_or_equal_to: :electric_start }
  validates :water_start, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :water_end, presence: true, numericality: { greater_than_or_equal_to: :water_start }
  validates :unit_price_internet, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :unit_price_parking_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :unit_price_service_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :reduce, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :day_used_per_month, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }
  validates :quantity_parking, presence: true, numericality: { greater_than_or_equal_to: 0 }

  attr_reader :invoice_attributes

  def initialize(invoice_attributes = {})
    super invoice_attributes
    @invoice_attributes = invoice_attributes
  end

  def update
    send "update_step_#{step}"
  end

  private

  def invoice
    @invoice ||= record || Invoice.new
  end

  def update_step_confirmation
    return false unless valid?

    true
  end

  # rubocop:disable Metrics/AbcSize
  def update_step_done
    return false unless valid?

    ActiveRecord::Base.transaction do
      invoice.update!(invoice_item)
      invoice.item_electric.update! electric_item
      invoice.item_water.update! water_item
      invoice.item_internet.update! internet_item
      invoice.item_parking_fee.update! parking_fee_item
      invoice.item_service.update! service_fee_item
    end

    true
  end

  # rubocop:enable Metrics/AbcSize
  def calculate_ratio_day_lived
    @calculate_ratio_day_lived ||= day_used_per_month.to_f / invoice.date_export.end_of_month.day
  end

  def invoice_item
    {
      reduce: reduce,
      total: total,
      day_lived: day_used_per_month
    }
  end

  def electric_item
    {
      unit: Settings.unit.electric,
      unit_price: Settings.unit_price.electric,
      begin_number: electric_start,
      end_number: electric_end,
      quantity: electric_quantity,
      total: electric_quantity * Settings.unit_price.electric
    }
  end

  def water_item
    {
      unit: Settings.unit.water,
      unit_price: Settings.unit_price.water,
      begin_number: water_start,
      end_number: water_end,
      quantity: water_quantity,
      total: water_quantity * Settings.unit_price.water
    }
  end

  def internet_item
    {
      unit: Settings.unit.internet,
      unit_price: unit_price_internet,
      quantity: 1,
      total: unit_price_internet * calculate_ratio_day_lived
    }
  end

  def parking_fee_item
    {
      unit: Settings.unit.parking_fee,
      unit_price: unit_price_parking_fee,
      quantity: quantity_parking,
      total: unit_price_parking_fee * quantity_parking * calculate_ratio_day_lived
    }
  end

  def service_fee_item
    {
      unit: Settings.unit.service,
      unit_price: unit_price_service_fee,
      quantity: 1,
      total: unit_price_service_fee * calculate_ratio_day_lived
    }
  end

  def electric_quantity
    (electric_end - electric_start).to_f
  end

  def water_quantity
    (water_end - water_start).to_f
  end
end
