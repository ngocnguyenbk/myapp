class RoomSerializer < ActiveModel::Serializer
  attributes :id, :room_number, :total_users, :status, :holder_id, :area

  def total_users
    object.users_count
  end
end
