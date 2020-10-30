module Api
  class UsersController < ApplicationController
    layout false

    def index
      @users = users
    end

    private

    def users
      room.users.without_deleted.presence || User.without_deleted
    end

    def room
      Room.find_by(id: params[:room_id])
    end
  end
end
