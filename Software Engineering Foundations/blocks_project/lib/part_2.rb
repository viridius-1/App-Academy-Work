require 'byebug'

#method that returns true if all words in an array are properly capitalized 
def all_words_capitalized?(arr)
    arr.all? { |word| word == word.capitalize} 
end 

#method takes in array of urls. returns true if no urls end in '.com', '.net', '.io', or '.org'. 
def no_valid_url?(urls)
    url_ends = ['com', 'net', 'io', 'org'] 
    urls.none? do |url| 
        url_arr = url.split('.')
        url_ends.include?(url_arr[1])
    end 
end

#method takes in array of hashes of students and their grades. returns true when at least 1 student in the array has an avg grade of 75 or higher. 
def any_passing_students?(students)
    
    students.any? do |student| 
        student_grades = student[:grades]
        avg_grade = (student_grades.sum/student_grades.length).to_f 
        avg_grade > 75 
    end 

end 