class DetailContractSerializer < ActiveModel::Serializer
  attributes :months_rented, :months_remaining, :total_moneys

  def months_rented
    object.total_months_rented
  end

  def months_remaining
    object.total_months_remaining
  end

  def total_moneys
    object.total_months_rented * object.room_price
  end
end
