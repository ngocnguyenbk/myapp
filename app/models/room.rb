class Room < ApplicationRecord
  include SoftDeletable

  enum status: { hired: 0, empty: 1, deposited: 2 }

  has_many :users
  belongs_to :floor
end
