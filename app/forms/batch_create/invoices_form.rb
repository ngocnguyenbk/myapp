module BatchCreate
  class InvoicesForm
    include Virtus.model
    include ActiveModel::Model

    DEFAULT_QUANTITY = 1

    attr_reader :date

    attribute :invoice_attributes, Array
    attribute :date_export, String

    validates :date_export, presence: true

    def self.name
      "BatchCreate::Invoices"
    end

    def initialize(invoice_attributes = {}, date)
      @invoice_attributes = invoice_attributes
      @date = date
    end

    def build_form
      invoice_detail = {}
      rooms.each do |room|
        contract = room.contract_active

        invoice_detail[room.room_number] = {}
        next if contract.blank? || contract.invoices.in_month(date).exists?

        invoice_detail[room.room_number] = add_contract(contract)
        invoice_detail[room.room_number].merge! add_invoice
        invoice_detail[room.room_number].merge! add_resource_item(contract)
        invoice_detail[room.room_number].merge! add_service_item
        invoice_detail[room.room_number].merge! add_extend_data(contract)
      end

      invoice_detail
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def save
      unit_price_electric = Settings.unit_price.electric
      unit_price_water = Settings.unit_price.water
      unit_price_internet = Settings.unit_price.internet
      unit_price_parking_fee = Settings.unit_price.parking_fee
      unit_price_service = Settings.unit_price.service

      ele_unit = Settings.unit.electric
      wat_unit = Settings.unit.water
      int_unit = Settings.unit.internet
      paf_unit = Settings.unit.parking_fee
      ser_unit = Settings.unit.service
      num_day_in_month = date_export.end_of_month.day

      resource_item = []
      service_item = []

      ActiveRecord::Base.transaction do
        invoice_attributes.to_h.each_with_object({}) do |(_room_number, item)|
          invoice = Invoice.create! item[:invoice].merge(day_lived: num_day_in_month, day_in_month: num_day_in_month)
          resource_item.push invoice.item_electrics.new item[:electric].merge(unit: ele_unit, unit_price: unit_price_electric)
          resource_item.push invoice.item_waters.new item[:water].merge(unit: wat_unit, unit_price: unit_price_water)
          service_item.push invoice.item_internets.new item[:internet].merge(unit: int_unit, unit_price: unit_price_internet)
          service_item.push invoice.item_parking_fees.new item[:parking_fee].merge(unit: paf_unit,
                                                                                   unit_price: unit_price_parking_fee)
          service_item.push invoice.item_services.new item[:service].merge(unit: ser_unit, unit_price: unit_price_service)
        end
        ResourceItem.import! resource_item
        ServiceItem.import! service_item
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    private

    def add_contract(contract)
      {
        contract: {
          contract_id: contract.id,
          deposited_money: contract.deposited_money,
          room_price: contract.room_price
        }
      }
    end

    def add_invoice
      {
        invoice: {
          date_export: date,
          reduce: 0
        }
      }
    end

    def add_resource_item(contract)
      month_ago = date.to_date.months_ago(1)

      invoice_month_ago = contract.invoices.in_month(month_ago).first
      ele_start = 0
      wat_start = 0

      if invoice_month_ago.present?
        electric = invoice_month_ago.item_electric
        water = invoice_month_ago.item_water

        ele_start = electric.end_number
        wat_start = water.end_number
      end

      {
        electric: { begin_number: ele_start, end_number: 0, quantity: 0, total: 0, unit_price: Settings.unit_price.electric },
        water: { begin_number: wat_start, end_number: 0, quantity: 0, total: 0, unit_price: Settings.unit_price.water }
      }
    end

    def add_service_item
      total_internet = Settings.unit_price.internet * DEFAULT_QUANTITY
      total_service = Settings.unit_price.service * DEFAULT_QUANTITY

      {
        parking_fee: { quantity: 0, total: 0, unit_price: Settings.unit_price.parking_fee },
        internet: { quantity: DEFAULT_QUANTITY, total: total_internet, unit_price: Settings.unit_price.internet },
        service: { quantity: DEFAULT_QUANTITY, total: total_service, unit_price: Settings.unit_price.service }
      }
    end

    def add_extend_data(contract)
      {
        extend_data: {
          holder_name: contract.holder_full_name
        }
      }
    end

    def rooms
      @rooms ||= Room.all.includes(:contract_active)
    end
  end
end
