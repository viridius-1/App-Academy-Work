# == Schema Information
#
# Table name: courses
#
#  id            :integer(8)      not null, primary key
#  name          :string
#  prereq_id     :integer
#  instructor_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null


class Course < ApplicationRecord
    has_many :enrollments, 
        primary_key: :id,
        foreign_key: :course_id, #enrollments table 
        class_name: :Enrollment 

    has_many :enrolled_students, 
        through: :enrollments, 
        source: :user

    belongs_to :prereq, 
        class_name: :Course,
        foreign_key: :prereq_id,
        primary_key: :id  

    belongs_to :instructor, 
        class_name: :User, 
        foreign_key: :instructor_id, #courses table 
        primary_key: :id 
end


