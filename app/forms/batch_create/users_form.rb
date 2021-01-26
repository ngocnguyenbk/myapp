module BatchCreate
  class UsersForm
    include Virtus.model
    include ActiveModel::Model

    attr_accessor :users, :error_child

    attribute :user_attributes, Hash

    def self.name
      "BatchCreate::User"
    end

    def user_attributes=(attributes)
      @error_child = {}
      @users = attributes.map.with_index do |(_int, user_params), index|
        user_form = ::UsersForm.new(user_params)
        check_validate(user_form, index)
        user_form
      end
    end

    def save
      return false if error_child.any?

      @users.each(&:save)
    end

    private

    def check_validate(user_form, index)
      return true if user_form.valid?

      @error_child[index] = user_form.errors.messages
    end
  end
end
