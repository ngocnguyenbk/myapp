class CreateContractHistoryService
  attr_reader :contract, :current_admin, :description, :code

  def initialize(contract, current_admin, description, code)
    @contract = contract
    @current_admin = current_admin
    @description = description
    @code = code
  end

  def perform
    current_admin.contract_histories.create!(date_changed: Time.zone.now,
                                             description: description,
                                             contract_id: contract.id,
                                             code: code)
  end
end
