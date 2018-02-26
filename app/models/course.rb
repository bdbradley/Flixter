class Course < ApplicationRecord
  belongs_to :user
  has_many :sections
  has_many :enrollments
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :description, presence: true
  validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}
  
  #If course is free = zero dollars
   def free?
    cost.zero?
  end

  #If course is premium then it's not free
  def premium?
    ! free?
  end
end
