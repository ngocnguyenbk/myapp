class UsersForm < BaseForm
  attribute :id, Integer
  attribute :birthday, String
  attribute :email, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :phone, String
  attribute :identity_card, String
  attribute :room_id, Integer

  validates :birthday, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: true, model: User }, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true, uniqueness: { case_sensitive: true, model: User },
                    numericality: { only_integer: true }, length: { in: 9..11 }
  validates :room_id, presence: true

  delegate :persisted?, :id, to: :user

  def self.name
    "User"
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      user.update!(attributes)
    end

    true
  end

  delegate :destroy, to: :user

  private

  def user
    @user ||= record || User.new
  end
end
