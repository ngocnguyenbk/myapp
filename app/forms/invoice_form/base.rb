module InvoiceForm
  class Base < BaseForm
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

    validates :room_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :electric_start, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :electric_end, presence: true, numericality: { greater_than_or_equal_to: proc { |base| base.electric_start.to_i } }
    validates :water_start, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :water_end, presence: true, numericality: { greater_than_or_equal_to: proc { |base| base.water_start.to_i } }
    validates :unit_price_internet, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :unit_price_parking_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :unit_price_service_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :reduce, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :day_used_per_month, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }
    validates :quantity_parking, presence: true, numericality: { greater_than_or_equal_to: 0 }

    def initialize(invoice_attributes = {})
      super invoice_attributes
    end

    private

    def calculate_ratio_day_lived
      raise NotImplementedError
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
end
