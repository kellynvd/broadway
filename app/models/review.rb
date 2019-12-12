class Review < ApplicationRecord
  belongs_to :play
  belongs_to :user
  validates_numericality_of :rating, less_than: 5, message: 'must be between 0 and 5'

  def blank_stars
    5 - rating.to_i
  end
end
