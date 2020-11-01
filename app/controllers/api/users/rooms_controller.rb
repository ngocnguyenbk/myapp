module Api
  module Users
    class RoomsController < ApplicationController
      def index
        @rooms = Room.empty
      end
    end
  end
end
