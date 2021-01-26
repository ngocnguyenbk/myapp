module BatchCreate
  class UsersController < ApplicationController
    STEPS = { confirmation: "confirmation", done: "done" }.freeze

    def create
      @form = if params.dig(:users, :step) == STEPS[:done]
                BatchCreate::UsersImportForm.new(submit_user_params)
              else
                BatchCreate::UsersImportForm.new(user_params)
              end

      if @form.save
        flash[:success] = t(".success")
        render json: { status: :ok }
      else
        render json: { users: @form.users, errors: @form.error_child }
      end
    end

    private

    def user_params
      params.require(:users).permit(:file, :step)
    end

    def submit_user_params
      params.require(:users).permit(:step, import_users: {})
    end
  end
end
