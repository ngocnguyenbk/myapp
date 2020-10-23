class FloorSerializer < ActiveModel::Serializer
  attributes :floor_id

  has_many :rooms, key: :rooms, serializer: RoomSerializer
end
