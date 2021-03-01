class InvoiceForm < BaseForm
  attribute :month, String
  attribute :room_id, Integer
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
  attribute :electric_unit_price, Integer
  attribute :water_unit_price, Integer

  validates :month, presence: true
  validates :room_id, presence: true, numericality: { greater_than_or_equal_to: 0 }
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

  delegate :id, to: :contract

  def initialize(invoice_attributes = {})
    super invoice_attributes
    @invoice_attributes = invoice_attributes
  end

  def build_form
    {
      electric_unit_price: Settings.unit_price.electric,
      water_unit_price: Settings.unit_price.water
    }
  end

  def save
    return false unless valid?

    resource_item = []
    service_item = []
    ActiveRecord::Base.transaction do
      invoice = Invoice.create! invoice_item
      resource_item.push invoice.item_electrics.new electric_item
      resource_item.push invoice.item_waters.new water_item
      service_item.push invoice.item_internets.new internet_item
      service_item.push invoice.item_parking_fees.new parking_fee_item
      service_item.push invoice.item_services.new service_fee_item
      ResourceItem.import! resource_item
      ServiceItem.import! service_item
    end
  end

  private

  def contract
    @contract ||= Room.find(room_id).contract_active
  end

  def calculate_ratio_day_lived
    @calculate_ratio_day_lived ||= day_used_per_month.to_f / Date.parse(month).end_of_month.day
  end

  def invoice_item
    {
      date_export: Date.parse(month).to_datetime,
      reduce: reduce,
      total: total,
      contract_id: id
    }
  end

  def electric_item
    {
      unit: "ele_unit",
      unit_price: Settings.unit_price.electric,
      begin_number: electric_start,
      end_number: electric_end,
      quantity: electric_quantity,
      total: electric_quantity * Settings.unit_price.electric
    }
  end

  def water_item
    {
      unit: "wat_unit",
      unit_price: Settings.unit_price.water,
      begin_number: water_start,
      end_number: water_end,
      quantity: water_quantity,
      total: water_quantity * Settings.unit_price.water
    }
  end

  def internet_item
    {
      unit: "int_unit",
      unit_price: unit_price_internet,
      quantity: 1,
      total: unit_price_internet * calculate_ratio_day_lived
    }
  end

  def parking_fee_item
    {
      unit: "paf_unit",
      unit_price: unit_price_parking_fee,
      quantity: quantity_parking,
      total: unit_price_parking_fee * quantity_parking * calculate_ratio_day_lived
    }
  end

  def service_fee_item
    {
      unit: "ser_unit",
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
