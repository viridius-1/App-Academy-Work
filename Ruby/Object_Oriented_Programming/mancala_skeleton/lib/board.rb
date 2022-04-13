class Board

  attr_reader :name1, :name2
  attr_accessor :cups, :opponent_points_store_idx, :player_points_store_idx

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2 
    @player_points_store_idx = nil 
    @opponent_points_store_idx = nil 
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
      true 
  end

  def update_points_store_idx(player_name)
    if player_name == name1
      @player_points_store_idx = 6
      @opponent_points_store_idx = 13 
    else 
      @player_points_store_idx = 13 
      @opponent_points_store_idx = 6 
    end 
  end 

  def remove_stones(position)
    cups[position] = []
  end 

  def distribute_stones(stones_to_distribute, start_pos)
    next_position_hash = { 0 => 1, 1 => 2, 2 => 3, 3 => 4, 4 => 5, 5 => 6, 6 => 7, 7 => 8, 8 => 9, 9 => 10, 10 => 11, 11 => 12, 12 => 13, 13 => 0}
    starting_idx = next_position_hash[start_pos] 

    cup_idx = starting_idx
    until stones_to_distribute == 0 
      if cup_idx != opponent_points_store_idx
        @cups[cup_idx] << :stone 
        stones_to_distribute -= 1 
      end 
      cup_idx = next_position_hash[cup_idx] if stones_to_distribute > 0 
    end 

    next_turn(cup_idx)
  end 

  def make_move(start_pos, current_player_name)
      update_points_store_idx(current_player_name)
      stones_to_distribute = cups[start_pos].length 
      remove_stones(start_pos)
      distribute_stones(stones_to_distribute, start_pos)
  end

  def next_turn(ending_cup_idx)
    next_turn_value = nil 

    if ending_cup_idx == player_points_store_idx
      next_turn_value = :prompt 
    elsif cups[ending_cup_idx].length == 1 
      next_turn_value = :switch 
    elsif cups[ending_cup_idx].length > 1 
      next_turn_value = ending_cup_idx 
    end 

    render
    next_turn_value 
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def side_empty?(side) 
    side.all? { |cup| cup.empty? }
  end 

  def one_side_empty?
    side_empty?(cups[0..5]) || side_empty?(cups[6..12])
  end

  def winner
    if cups[6].length > cups[13].length 
      name1 
    elsif cups[6].length < cups[13].length 
      name2 
    else 
      :draw 
    end 
  end

end
