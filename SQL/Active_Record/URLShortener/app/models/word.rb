<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 88ef3aff14aeca3308f8a05cbfae2665ad340e28
# == Schema Information
#
# Table name: words
#
#  id   :integer(8)      not null, primary key
#  word :string          not null 


class Word < ApplicationRecord 
    validates :word, presence: true 
end 
<<<<<<< HEAD
=======
=======
class Word < ApplicationRecord 
    validates :word, presence: true 
end 
>>>>>>> 5291bfb (Add Word model & words table. Add dictionary.txt to db dir. Add code to seeds.rb to try to seed database with dictionary words)
>>>>>>> 88ef3aff14aeca3308f8a05cbfae2665ad340e28
