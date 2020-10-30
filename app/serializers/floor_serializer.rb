class FloorSerializer < ActiveModel::Serializer
  attributes :floor_number

  has_many :rooms, key: :rooms, serializer: RoomSerializer
end
