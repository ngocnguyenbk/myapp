class ResourceItem < ApplicationRecord
  belongs_to :invoice

  scope :electrics, -> { where(type: "Item::Electric") }
  scope :waters, -> { where(type: "Item::Water") }

  def self.type
    %w[Item::Electric Item::Water]
  end
end
