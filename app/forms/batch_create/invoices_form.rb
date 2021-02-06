module BatchCreate
  class InvoicesForm
    include Virtus.model
    include ActiveModel::Model

    DEFAULT_QUANTITY = 1

    attr_reader :current_date

    attribute :invoice_attributes, Array

    def self.name
      "BatchCreate::Invoices"
    end

    def initialize
      @current_date = Time.zone.now
    end

    def build_form
      invoice_detail = {}
      rooms.each do |room|
        contract = room.contract_active

        invoice_detail[room.room_number] = {}
        next if contract.blank?

        invoice_detail[room.room_number] = add_contract(contract)
        invoice_detail[room.room_number].merge! add_invoice
        invoice_detail[room.room_number].merge! add_resource_item(contract)
        invoice_detail[room.room_number].merge! add_service_item
        invoice_detail[room.room_number].merge! add_extend_data(contract)
      end

      invoice_detail
    end

    private

    def add_contract(contract)
      {
        contract: {
          deposited_money: contract.deposited_money,
          room_price: contract.room_price
        }
      }
    end

    def add_invoice
      {
        invoice: {
          date_export: current_date.strftime("%d/%m/%Y %H:%M:%S"),
          reduce: 0
        }
      }
    end

    def add_resource_item(contract)
      invoice_month_ago = contract.invoice_month_ago
      ele_start = 0
      wat_start = 0

      if invoice_month_ago.present?
        electric = invoice_month_ago.item_electrics
        water = invoice_month_ago.item_waters

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
      @rooms ||= Room.all.includes(contract_active: [:holder, invoice_month_ago: [:item_electrics, :item_waters]])
    end
  end
end
