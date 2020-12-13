class ExtendContractForm < BaseForm
  STEPS = { confirmation: "confirmation", done: "done" }.freeze

  attribute :number_months, Integer
  attribute :step, String

  validates :number_months, presence: true, numericality: { only_integer: true }

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
