class ContractsForm < BaseForm
  attribute :holder_id, Integer
  attribute :room_id, Integer
  attribute :room_price, String
  attribute :deposited_money, String
  attribute :started_date, String
  attribute :ended_date, String

  validates :holder_id, presence: true
  validates :room_id, presence: true
  validates :room_price, presence: true
  validates :started_date, presence: true
  validates :ended_date, presence: true

  delegate :persisted?, :destroy, :id, to: :contract

  def self.name
    "Contract"
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      contract.update!(attributes)

      contract.room.update!(status: "deposited")
    end

    true
  end

  delegate :destroy, to: :contract

  private

  def contract
    @contract ||= record || Contract.new
  end
end
