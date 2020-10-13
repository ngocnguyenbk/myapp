class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include SoftDeletable

  validates :phone, uniqueness: { case_sensitive: true }, numericality: { only_integer: true }, length: { in: 9..11 }
end
