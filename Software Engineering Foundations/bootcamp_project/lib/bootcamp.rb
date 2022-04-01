#Bootcamp class
class Bootcamp 

    def initialize(name, slogan, student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity 
        @teachers = []
        @students = []
        @grades = Hash.new { |hash, k| hash[k] = [] }
    end 

    def name
        @name 
    end 

    def slogan
        @slogan
    end 

    def teachers
        @teachers
    end 

    def students 
        @students 
    end 

    def hire(teacher)
        @teachers << teacher 
    end 

    def enroll(student)
        if @students.length < @student_capacity 
            @students << student 
            true 
        elsif @students.length == @student_capacity 
            false 
        end 
    end 

    def enrolled?(student)
        @students.include?(student)
    end 

    def student_to_teacher_ratio
        @students.length / @teachers.length 
    end 

    def add_grade(student, grade)
        if enrolled?(student)
            @grades[student] << grade 
            true 
        else 
            false 
        end 
    end 

    def num_grades(student)
        @grades[student].length 
    end 

    #returns avg grade of student. returns nil if student is not enrolled or if student has no grades.
    def average_grade(student)
        if enrolled?(student) && @grades[student].length > 0 
            @grades[student].sum / @grades[student].length 
        else 
            nil 
        end 
    end 

end 

