class ContractsForm < BaseForm
  DISPLAY_DATE = "%d/%m/%Y".freeze

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

  validate :ended_date_must_greater_than_started_date, if: -> { started_date.present? }

  attr_reader :current_admin

  delegate :persisted?, :destroy, :id, to: :contract

  def self.name
    "Contract"
  end

  def initialize(params, current_admin)
    @current_admin = current_admin

    super params
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      contract.update!(attributes)

      contract.room.update!(status: :hired)
      CreateContractHistoryService.new(contract, current_admin, attributes, "add").perform
    end

    true
  end

  def destroy
    ActiveRecord::Base.transaction do
      room = contract.room
      room.update!(status: :empty, holder_id: nil)
      room.users.destroy_all
      contract.destroy

      assign_from_model
      description = attributes.slice(:holder_id, :room_id).merge(time_release: Time.zone.now)
      CreateContractHistoryService.new(contract, current_admin, description, "terminate").perform
    end
  end

  private

  def contract
    @contract ||= record || Contract.new
  end

  def ended_date_must_greater_than_started_date
    return true if Date.parse(started_date) < Date.parse(ended_date)

    errors.add(:ended_date, I18n.t(".contracts_form.must_be_greater_than",
                                   start: Date.parse(started_date).strftime(DISPLAY_DATE)))
  end
end
