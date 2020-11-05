class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include SoftDeletable

  enum role: { admin: 0, accountant: 1 }

  validates :full_name, presence: true
  validates :phone, uniqueness: { case_sensitive: true },
                    numericality: { only_integer: true }, length: { in: 9..11 }
  validates :birthday, presence: true
  validates :role, presence: true
end
