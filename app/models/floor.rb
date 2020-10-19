class Floor < ApplicationRecord
  include SoftDeletable

  has_many :rooms
end
