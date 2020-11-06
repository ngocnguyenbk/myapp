class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :first_name, :last_name, :email, :phone, :birth_day, :created_date, :status_active

  def status_active
    object.active
  end

  def created_date
    object.created_date.format_with_separate
  end

  def birth_day
    object.birth_day.format_with_separate
  end
end
