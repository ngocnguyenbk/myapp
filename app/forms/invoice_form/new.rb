module InvoiceForm
  class New < Base
    attribute :month, String
    attribute :room_id, Integer
    attribute :electric_unit_price, Integer
    attribute :water_unit_price, Integer

    validates :month, presence: true
    validates :room_id, presence: true, numericality: { greater_than_or_equal_to: 0 }

    delegate :id, to: :contract

    attr_accessor :form

    def build_form
      @form = {
        electric_unit_price: Settings.unit_price.electric,
        water_unit_price: Settings.unit_price.water,
        unit_price_internet: Settings.unit_price.internet,
        unit_price_parking_fee: Settings.unit_price.parking_fee,
        unit_price_service_fee: Settings.unit_price.service
      }
      return form if room_id.blank?

      form[:room_price] = contract.room_price

      return form if month.blank?

      add_form_detail

      form
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

    def invoice_in_month?
      contract.invoices.in_month(month).exists?
    end

    private

    attr_reader :current_invoice, :current_invoice_ago

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

    def add_form_detail
      @current_invoice ||= contract.invoices.in_month(month).first
      return current_invoice_meter_reading if current_invoice

      @current_invoice_ago ||= contract.invoices.in_month(Date.parse(month) - 1.month).first
      return current_invoice_ago_meter_reading if current_invoice_ago

      zero_all_meter_reading
    end

    def zero_all_meter_reading
      form.merge!({
                    electric_start: 0,
                    electric_end: 0,
                    water_start: 0,
                    water_end: 0,
                    quantity_parking: 0
                  })
    end

    def current_invoice_meter_reading
      form.merge!({
                    electric_start: current_invoice.item_electric.begin_number,
                    electric_end: current_invoice.item_electric.end_number,
                    water_start: current_invoice.item_water.begin_number,
                    water_end: current_invoice.item_water.end_number,
                    quantity_parking: current_invoice.item_parking_fee.quantity,
                    unit_price_parking_fee: current_invoice.item_parking_fee.unit_price,
                    unit_price_internet: current_invoice.item_internet.unit_price,
                    unit_price_service_fee: current_invoice.item_service.unit_price
                  })
    end

    def current_invoice_ago_meter_reading
      form.merge!({
                    electric_start: current_invoice_ago.item_electric.end_number,
                    electric_end: 0,
                    water_start: current_invoice_ago.item_water.end_number,
                    water_end: 0,
                    quantity_parking: current_invoice_ago.item_parking_fee.quantity,
                    unit_price_parking_fee: current_invoice_ago.item_parking_fee.unit_price,
                    unit_price_internet: current_invoice_ago.item_internet.unit_price,
                    unit_price_service_fee: current_invoice_ago.item_service.unit_price
                  })
    end
  end
end
