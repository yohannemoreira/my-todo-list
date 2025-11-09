class List < ApplicationRecord
  has_many :todos

  validates :name, presence: true
end
