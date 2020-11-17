class Contract < ApplicationRecord
  include SoftDeletable

  belongs_to :holder, class_name: User.name, optional: true
  belongs_to :room, class_name: Room.name, optional: true

  delegate :room_number, to: :room, prefix: true, allow_nil: true
  delegate :full_name, to: :holder, prefix: true, allow_nil: true

  def start_date
    DateFormat.new(started_date)
  end

  def end_date
    DateFormat.new(ended_date)
  end
end
