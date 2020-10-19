class RoomSerializer < ActiveModel::Serializer
  attributes :room_id, :total_users, :status

  def total_users
    object.users.without_deleted.count
  end
end
