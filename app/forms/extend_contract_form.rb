class ExtendContractForm < BaseForm
  STEPS = { confirmation: "confirmation", done: "done" }.freeze

  attribute :number_months, Integer
  attribute :step, String

  validates :number_months, presence: true, numericality: { only_integer: true }

  attr_reader :current_admin

  def initialize(params, current_admin)
    @current_admin = current_admin

    super params
  end

  def self.name
    "ExtendContract"
  end

  def save
    return false unless valid?

    send "save_step_#{step}"
  end

  private

  def save_step_done
    return false unless valid?

    ActiveRecord::Base.transaction do
      contract.update!(ended_date: extend_ended_date)

      descriptions = attributes.merge(ended_date: contract.ended_date).except(:step)
      CreateContractHistoryService.new(contract, current_admin, descriptions, "extend").perform
    end

    true
  end

  def save_step_confirmation
    true
  end

  def extend_ended_date
    contract.ended_date + number_months.months
  end

  def contract
    @contract = record
  end
end
