module BatchCreate
  class InvoicesForm
    include Virtus.model
    include ActiveModel::Model

    DEFAULT_QUANTITY = 1

    attribute :invoice_attributes, Array
    attribute :month, String

    attr_reader :room_numbers

    validates :month, presence: true

    def self.name
      "BatchCreate::Invoices"
    end

    def initialize(month = "", invoice_attributes = {})
      @month = month
      @invoice_attributes = invoice_attributes
    end

    def build_form
      invoice_detail = {}
      rooms.each do |room|
        contract = room.contract_active

        invoice_detail[room.room_number] = {}
        next if contract.blank?

        invoice_params = {
          month: month,
          room_id: room.id
        }
        form = InvoiceForm::New.new(invoice_params).build_form
        invoice_detail[room.room_number] = add_contract(contract)
        invoice_detail[room.room_number].merge! add_extend_data(contract)
        invoice_detail[room.room_number].merge! add_invoice(form)
        invoice_detail[room.room_number].merge! add_resource_item(form)
        invoice_detail[room.room_number].merge! add_service_item(form)
      end
      invoice_detail
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def save
      ActiveRecord::Base.transaction do
        invoice_attributes.to_h.each_with_object({}) do |(room_number, item)|
          @room_numbers ||= []
          @room_numbers.push(room_number)
          invoice_params = {
            month: month,
            room_id: item[:invoice][:room_id],
            day_used_per_month: item[:invoice][:day_used_per_month],
            electric_start: item[:electric][:begin_number],
            electric_end: item[:electric][:end_number],
            water_start: item[:water][:begin_number],
            water_end: item[:water][:end_number],
            unit_price_internet: item[:internet][:unit_price],
            unit_price_parking_fee: item[:parking_fee][:unit_price],
            quantity_parking: item[:parking_fee][:quantity],
            unit_price_service_fee: item[:service][:unit_price],
            electric_unit_price: item[:electric][:unit_price],
            water_unit_price: item[:water][:unit_price],
            reduce: item[:invoice][:reduce],
            total: item[:invoice][:total]
          }

          form = InvoiceForm::New.new(invoice_params)
          return false unless form.valid?

          form.save
        end
      end
    end

    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def invoice_already_exist?
      already_exists = false
      room_number_exists = ""
      invoice_attributes.to_h.each do |room_number, room_attribute|
        contract_id = room_attribute[:invoice][:contract_id]
        month = room_attribute[:invoice][:date_export]
        next unless Contract.find(contract_id).invoices.in_month(month).exists?

        already_exists = true
        room_number_exists = room_number
        break
      end

      [already_exists, room_number_exists]
    end

    private

    def add_contract(contract)
      {
        contract: {
          contract_id: contract.id,
          deposited_money: contract.deposited_money,
          room_price: contract.room_price,
          room_id: contract.room.id
        }
      }
    end

    def add_invoice(form)
      {
        invoice: {
          day_used_per_month: form[:day_used_per_month],
          date_export: month,
          reduce: form[:reduce]
        }
      }
    end

    def add_resource_item(form)
      {
        electric: {
          begin_number: form[:electric_start],
          end_number: form[:electric_end],
          quantity: form[:electric_quantity],
          unit_price: form[:electric_unit_price]
        },
        water: {
          begin_number: form[:water_start],
          end_number: form[:water_end],
          quantity: form[:water_quantity],
          unit_price: form[:water_unit_price]
        }
      }
    end

    def add_service_item(form)
      {
        parking_fee: { quantity: form[:quantity_parking], total: 0, unit_price: form[:unit_price_parking_fee] },
        internet: { quantity: DEFAULT_QUANTITY, total: 0, unit_price: form[:unit_price_internet] },
        service: { quantity: DEFAULT_QUANTITY, total: 0, unit_price: form[:unit_price_service_fee] }
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
      @rooms ||= Room.all.includes(contract_active: :holder)
    end
  end
end
