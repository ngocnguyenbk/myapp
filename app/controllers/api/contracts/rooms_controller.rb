module Api
  module Contracts
    class RoomsController < ApplicationController
      def index
        @rooms = Room.empty
      end
    end
  end
end
