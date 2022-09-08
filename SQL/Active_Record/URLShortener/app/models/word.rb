<<<<<<< HEAD
<<<<<<< HEAD
# == Schema Information
#
# Table name: words
#
#  id   :integer(8)      not null, primary key
#  word :string          not null 


class Word < ApplicationRecord 
    validates :word, presence: true 
end 
=======
class Word < ApplicationRecord 
    validates :word, presence: true 
end 
>>>>>>> 5291bfb (Add Word model & words table. Add dictionary.txt to db dir. Add code to seeds.rb to try to seed database with dictionary words)
=======
class Word < ApplicationRecord 
    validates :word, presence: true 
end 
>>>>>>> 257b92a89c73931ab5496af8c45a4fe3dd0a2d1d
