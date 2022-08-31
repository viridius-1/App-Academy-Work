# == Schema Information
#
# Table name: enrollments
#
#  id         :integer(8)      not null, primary key
#  course_id  :integer
#  student_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null


class Enrollment < ApplicationRecord
    belongs_to :user,
        primary_key: :id,
        foreign_key: :student_id, #enrollments table
        class_name: :User

    belongs_to :course, 
        primary_key: :id,  
        foreign_key: :course_id, #enrollments table
        class_name: :Course
end
