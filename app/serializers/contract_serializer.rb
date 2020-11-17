class ContractSerializer < ActiveModel::Serializer
  attributes :id, :holder_name, :room_number, :room_price, :deposited_money, :start_date, :end_date

  def room_number
    object.room_room_number
  end

  def holder_name
    object.holder_full_name
  end

  def start_date
    object.start_date.format_with_separate
  end

  def end_date
    object.end_date.format_with_separate
  end
end
