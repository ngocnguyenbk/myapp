module Api
  class RoomsController < ApplicationController
    layout false

    before_action :room, only: [:update]

    def update
      @form = RoomsForm.new(room_params)
      @form.record = @room
      @form.save
    end

    private

    def room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:id, :room_number, :holder_id, :status, :area)
    end
  end
end
