class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :review, presence: true
  validates :rating, presence: true
  validate :rating_should_be_from_one_to_five


  def rating_should_be_from_one_to_five
    if rating.present? && (rating < 1 || rating > 5)
      errors.add(:rating, "should be from 1 to 5")
    end
  end
end
