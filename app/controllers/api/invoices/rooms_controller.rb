module Api
  module Invoices
    class RoomsController < ApplicationController
      before_action :current_room, only: :show
      attr_reader :room

      def index
        @rooms = Room.hired
      end

      def show
        render json: {
          status: :ok,
          data: Api::Invoices::RoomSerializer.new(room)
        }
      end

      private

      def current_room
        @room = Room.find params[:id]
      end
    end
  end
end
