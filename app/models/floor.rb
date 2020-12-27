class Floor < ApplicationRecord
  include SoftDeletable

  has_many :rooms, -> { with_count_users }
end
