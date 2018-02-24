class User < ApplicationRecord
  has_many :courses
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

#Loops through empty array of enrolled courses and pushes each
#course user(student) is enrolled in into the array
#.collect method stores the enrollments in the enrolled_courses variable
    def enrolled_in?(course)
    return enrolled_courses.include?(course)
    end
end
