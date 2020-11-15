class RoomsForm < BaseForm
  attribute :id, Integer
  attribute :room_number, Integer
  attribute :holder_id, Integer
  attribute :area, Float
  attribute :status, String

  validates :room_number, presence: true, uniqueness: { case_sensitive: true, model: Room }

  delegate :persisted?, to: :room

  def self.name
    "Room"
  end

  def save
    return false if invalid?

    room.update!(attributes)

    if room.empty?
      room.update!(holder_id: nil)
      User.without_deleted.where(room_id: room.id).destroy_all
    end

    true
  end

  def room
    @room ||= record || Room.new
  end
end
