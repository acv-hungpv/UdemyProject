class Recipe < ApplicationRecord
  validates :name, :description, presence: true
  validates :description ,length: {minimum: 5, maximum: 500 }
  validates :chef_id, presence: true
  belongs_to :chef
  default_scope -> { order(updated_at: :desc)}

end