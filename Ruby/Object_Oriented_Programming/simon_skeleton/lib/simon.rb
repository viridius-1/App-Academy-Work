class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    introduction 
    @game_over = false 
    @seq = []
    @sequence_length = 0 
  end

  def introduction
    puts "Welcome to Simon!"
    puts "You'll be given a sequence of colors. Your job is to memorize the sequence and enter it. The game will end when you enter an incorrect sequence."
    puts "Hit return/enter to begin."
    gets
    clear  
  end 

  def play
    until game_over 
      take_turn
    end 
    game_over_message
    reset_game
    play_again? 
  end

  def take_turn
    unless game_over 
      show_sequence
      sleep 4
      clear 
      if require_sequence == seq 
        round_success_message
      else 
        @game_over = true 
      end 
    end 
  end

  def show_sequence
    add_random_color
    puts "SEQUENCE"
    seq.each { |color| print "#{color} " }
  end

  def require_sequence
    puts "Enter the sequence. Put a space between each color."
    user_seq = gets.chomp 
    user_seq.split 
  end

  def add_random_color
    @seq << COLORS.sample 
  end

  def round_success_message
    puts "Correct!"
    sleep 1 
    @sequence_length += 1 
    clear 
  end

  def game_over_message
    puts "You entered an incorrect sequence. Game over."
    puts "Score - #{sequence_length}"
  end

  def reset_game
    @game_over = false 
    @seq = []
    @sequence_length = 0 
  end

  def play_again?
    puts "\nEnter Y if you want to play again or any other key if you want to end."
    user_choice = gets.chomp.downcase  
    if user_choice == 'y'
      clear 
      play 
    end 
  end 

  def clear 
    system("clear")
  end 

end

s = Simon.new 
s.play 

