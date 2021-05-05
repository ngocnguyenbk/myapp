module Api
  module Invoices
    class RoomsController < ApplicationController
      def index
        @rooms = Room.hired
      end
    end
  end
end
