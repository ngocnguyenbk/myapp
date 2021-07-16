class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  include SoftDeletable
  has_one_attached :avatar

  belongs_to :room

  def created_date
    DateFormat.new(created_at)
  end

  def birth_day
    DateFormat.new(birthday)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def image_url
    rails_blob_path(avatar) if avatar.attached?
  end
end
