class Hangman

  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end 

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5 
  end 

  def guess_word
    @guess_word
  end 
  
  def attempted_chars
    @attempted_chars
  end 

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end 

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end 

  def get_matching_indices(char)
    matching_indices = []
    @secret_word.each_char.with_index { |sec_char, idx| matching_indices << idx if sec_char == char } 
    matching_indices       
  end 

  def fill_indices(char, indices)
    indices.each { |indice| @guess_word[indice] = char } 
  end 

  def try_guess(char)
    #check if char is in secret word 
    if !(@secret_word.include?(char))
      @remaining_incorrect_guesses -= 1 
    else 
      indices = get_matching_indices(char)
      fill_indices(char, indices)
    end 

    #check if character was already attempted 
    if !(already_attempted?(char)) 
      @attempted_chars << char 
      true  
    else 
      puts "that has already been attempted" 
      false
    end 
  end 

  def ask_user_for_guess
    print "Enter a char: "
    user_char = gets.chomp
    try_guess(user_char)
  end 

  def win?
    if @guess_word.join == @secret_word 
      puts "WIN"
      true 
    else 
      false 
    end 
  end 
  
  def lose? 
    if remaining_incorrect_guesses == 0 
      puts "LOSE"
      true 
    else 
      false 
    end 
  end 

  def game_over? 
    if win? || lose? 
      puts @secret_word
      true 
    else 
      false 
    end 
  end 

end 
