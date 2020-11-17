module Api
  module Contracts
    class UsersController < ApplicationController
      def index
        @users = User.all
      end
    end
  end
end
