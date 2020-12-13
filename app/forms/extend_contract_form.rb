class ExtendContractForm < BaseForm
  attribute :number_months, Integer

  validates :number_months, presence: true

  def self.name
    "ExtendContract"
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      contract.update!(ended_date: extend_ended_date)
    end

    true
  end

  private

  def extend_ended_date
    contract.ended_date + number_months.months
  end

  def contract
    @contract = record
  end
end
