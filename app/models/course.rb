class Course < ApplicationRecord
  has_one_attached :image

  has_many :lessons
end
