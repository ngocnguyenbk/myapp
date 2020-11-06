class UsersForm
  include Virtus.model
  include ActiveModel::Model

  attr_accessor :record

  attribute :id, Integer
  attribute :birthday, String
  attribute :email, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :phone, String

  validates :birthday, presence: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true

  def self.name
    "User"
  end

  def save
    return false unless valid?

    user.update!(attributes)
  end

  delegate :destroy, to: :user

  private

  def user
    @user ||= record || User.new
  end
end
