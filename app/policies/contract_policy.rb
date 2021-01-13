class ContractPolicy < ApplicationPolicy
  attr_reader :user, :contract

  def initialize(user, contract)
    @user = user
    @contract = contract
  end

  def destroy?
    contract.active
  end
end
