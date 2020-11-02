class RoomsForm
  include Virtus.model
  include ActiveModel::Model

  attr_accessor :record

  attribute :id, Integer
  attribute :room_number, Integer
  attribute :holder_id, Integer
  attribute :area, Float
  attribute :status, String

  def self.name
    "Room"
  end

  def save
    room.update!(attributes)

    return unless room.empty?

    room.update!(holder_id: nil)
    User.without_deleted.where(room_id: room.id).destroy_all
  end

  def room
    @room ||= record || Room.new
  end
end
