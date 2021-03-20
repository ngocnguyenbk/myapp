module InvoiceForm
  class New < Base
    attribute :month, String
    attribute :room_id, Integer
    attribute :electric_unit_price, Integer
    attribute :water_unit_price, Integer

    validates :month, presence: true
    validates :room_id, presence: true, numericality: { greater_than_or_equal_to: 0 }

    delegate :id, to: :contract

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
        contract_id: id,
        day_lived: day_used_per_month,
        day_in_month: Date.parse(month).end_of_month.day
      }
    end
  end
end
