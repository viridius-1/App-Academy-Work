require 'byebug'

class Board

  attr_reader :name1, :name2
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2 
    @cups = Array.new(14) { Array.new([]) }
    place_stones
  end

  def place_stones
    cups.each_with_index do |cup, idx| 
      4.times { cup << :stone } unless [6, 13].include?(idx)
    end 
  end

  def invalid_position?(position)
    !(0..5).include?(position) && !(7..12).include?(position)
  end 

  def valid_move?(start_pos)
      raise 'Invalid starting cup' if invalid_position?(start_pos)
      raise 'Starting cup is empty' if cups[start_pos].empty?  
  end

  def make_move(start_pos, current_player_name)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
