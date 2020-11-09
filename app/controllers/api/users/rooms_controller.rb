module Api
  module Users
    class RoomsController < ApplicationController
      def index
        @rooms = Room.all
      end
    end
  end
end
