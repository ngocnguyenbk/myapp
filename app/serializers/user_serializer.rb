class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :first_name, :last_name, :email, :phone, :birth_day,
             :created_date, :status_active, :room_number, :identity_card

  def status_active
    object.active
  end

  def created_date
    object.created_date.format_with_separate
  end

  def birth_day
    object.birth_day.format_with_separate
  end

  def room_number
    object.room.room_number
  end
end
