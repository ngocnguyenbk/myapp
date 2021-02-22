module Api
  module Invoices
    class RoomSerializer < ActiveModel::Serializer
      attributes :room_id, :room_price, :electric_start, :water_start, :unit_price_internet, :unit_price_parking_fee,
                 :unit_price_service_fee

      def room_id
        object.id
      end

      def room_price
        object.contract_active.room_price
      end

      def electric_start
        invoice_month_ago&.item_electric&.end_number
      end

      def water_start
        invoice_month_ago&.item_water&.end_number
      end

      def unit_price_internet
        Settings.unit_price.internet
      end

      def unit_price_parking_fee
        Settings.unit_price.parking_fee
      end

      def unit_price_service_fee
        Settings.unit_price.service
      end

      private

      def invoice_month_ago
        object.contract_active.invoice_month_ago
      end
    end
  end
end
