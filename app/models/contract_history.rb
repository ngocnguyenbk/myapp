class ContractHistory < ApplicationRecord
  belongs_to :admin
  belongs_to :contract

  enum code: { add: 0, extent: 1, terminate: 2 }
end
