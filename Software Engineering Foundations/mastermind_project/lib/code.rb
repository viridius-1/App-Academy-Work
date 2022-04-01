require "byebug"

class Code 
  
  attr_reader :pegs

  POSSIBLE_PEGS = {"R" => :red, "G" => :green, "B" => :blue, "Y" => :yellow}

  def self.valid_pegs?(chars)
    chars.map! { |char| char.upcase } 
    chars.each { |char| return false if !POSSIBLE_PEGS.has_key?(char) } 
    true 
  end 

  def self.random(length)
    rand_arr = []
    length.times { rand_arr << POSSIBLE_PEGS.keys.sample } 
    Code.new(rand_arr)
  end 

  def self.from_string(pegs)
    Code.new(pegs.split(''))
  end 

  def initialize(chars)
    if Code.valid_pegs?(chars) 
      @pegs = chars 
    else 
      raise "letters have invalid pegs"
    end 
  end 

  def [](idx)
    @pegs[idx]
  end 

  def length 
    @pegs.length
  end 

  def num_exact_matches(guess)
    matches = 0 
    guess.pegs.each_with_index { |guessed_peg, idx| matches += 1 if guessed_peg == @pegs[idx] } 
    matches 
  end 

  def num_near_matches(guess)
    near_matches = 0 
    near_matched_letters = []

    guess.pegs.each_with_index do |guessed_peg, guess_idx|
      
      if !(guessed_peg == @pegs[guess_idx])

          @pegs.each_with_index do |peg, peg_idx| 
            if peg == guessed_peg && peg != guess.pegs[peg_idx] && !(near_matched_letters.include?(guessed_peg))
              near_matches += 1 
              near_matched_letters << guessed_peg 
            end 
          end 

      end 

    end 

    near_matches 
  end 

  def ==(code)
    if @pegs.length == code.pegs.length 
      @pegs == code.pegs 
    else 
      false 
    end 
  end 
  
end 