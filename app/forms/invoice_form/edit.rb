module InvoiceForm
  class Edit < Base
    STEP = %w[confirmation done].freeze

    attribute :id, Integer
    attribute :step, String

    validates :step, presence: true, inclusion: { in: STEP }

    def update
      send "update_step_#{step}"
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

    private

    def invoice
      @invoice ||= record
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
  end
end
