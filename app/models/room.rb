class Room < ApplicationRecord
  include SoftDeletable

  enum status: { hired: 0, empty: 1, deposited: 2 }

  has_many :users
  belongs_to :floor

  scope :with_count_users, -> {
                             joins("LEFT JOIN users ON rooms.id = users.room_id")
                               .select("rooms.*, count(case when users.active = 1 then 1 else null end) as users_count")
                               .group("rooms.id")
                           }
end
