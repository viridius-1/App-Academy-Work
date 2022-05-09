require_relative 'deck'

class Hand 

    attr_accessor :hand, :suits, :values 

    def initialize(deck)
      @hand = deck.deal(5)
      @suits = nil 
      @values = nil 
    end 

    def remove_card(idx)
      hand.delete_at(idx)
    end 

    def add_card(card)
      @hand << card 
    end 

    #method calculates the rank of a hand 
    def calculate
      get_suits
      get_values

      if straight_flush?
        1
      elsif four_of_a_kind?
        2
      elsif full_house? 
        3 
      elsif flush?
        4
      elsif straight?
        5
      elsif three_of_a_kind? 
        6 
      elsif two_pair?
        7
      elsif one_pair? 
        8 
      else
        9 
      end  
    end 

    #method returns the rank of the high card in a set of cards 
    def rank(cards)
      highest_rank = nil 
      cards.each { |card| highest_rank = card.value if highest_rank == nil || card.value > highest_rank }  
      highest_rank
    end 

    def get_suits
      @suits = []
      hand.each { |card| @suits << card.suit }
    end 

    def get_values 
      @values = []
      hand.each { |card| @values << card.value }
    end 

    def all_cards_have_same_suit?
      suit_of_first_card_in_hand = suits[0]
      suits.all? { |suit| suit == suit_of_first_card_in_hand }
    end 

    def all_cards_have_values_that_differ_by_1?
      values.sort!.reverse!
      
      idx = 0 
      while idx < values.length - 1 
        current_value = values[idx]
        next_value = values[idx + 1]
        next_expected_value = current_value - 1 
        return false if next_value != next_expected_value
        idx += 1 
      end 

      true 
    end 

    def value_of_cards_with_same_value(kind_amount)
      values.each { |value| return value if values.count(value) == kind_amount } 
    end 

    def full_house_eval_two_other_cards_in_hand_have_same_value?(value_of_three_cards_with_same_value)
      values_of_two_other_cards = [] 
      values.each { |value| values_of_two_other_cards << value if value != value_of_three_cards_with_same_value } 
      values_of_two_other_cards.first == values_of_two_other_cards.last 
    end 

    def two_pair_eval_two_other_cards_in_hand_have_same_value?(value_of_two_cards_with_same_value)
      values_of_three_other_cards = [] 
      values.each { |value| values_of_three_other_cards << value if value != value_of_two_cards_with_same_value } 
      values_of_three_other_cards.each { |value| return true if values_of_three_other_cards.count(value) == 2 } 
      false 
    end 

    def cards_in_hand_have_same_value?(amount)
      values.each { |value| return true if values.count(value) == amount } 
      false 
    end 

    def straight_flush? 
      return false unless all_cards_have_same_suit?
      return false unless all_cards_have_values_that_differ_by_1?
      true 
    end 

    def four_of_a_kind?
      cards_in_hand_have_same_value?(4)
    end 

    def full_house?
      return false unless cards_in_hand_have_same_value?(3)
      value_of_three_cards_with_same_value = value_of_cards_with_same_value(3)
      full_house_eval_two_other_cards_in_hand_have_same_value?(value_of_three_cards_with_same_value)
    end 

    def flush? 
      all_cards_have_same_suit?
    end 

    def straight? 
      all_cards_have_values_that_differ_by_1?
    end 

    def three_of_a_kind?
      cards_in_hand_have_same_value?(3)
    end 

    def two_pair?
      return false unless cards_in_hand_have_same_value?(2)
      value_of_two_cards_with_same_value = value_of_cards_with_same_value(2)
      two_pair_eval_two_other_cards_in_hand_have_same_value?(value_of_two_cards_with_same_value)
    end 

    def one_pair?
      cards_in_hand_have_same_value?(2)
    end 

end 


=begin    
STRAIGHT FLUSH VS. STRAIGHT FLUSH 
-high card wins. draw goes to suit 

FOUR OF A KIND VS FOUR OF A KIND 
-high card within the four of a kind wins. 

FULL HOUSE VS FULL HOUSE 
-high card within the three cards wins

FLUSH VS FLUSH 
-high card within the flush wins. if tie, keep going to next card...if still tie at end, then winner decided by suit

STRAIGHT VS STRAIGHT 
-high card wins. draw goes to suit 

THREE OF A KIND VS THREE OF A KIND 
-high card within the three of a kind wins 

TWO PAIR VS TWO PAIR 
-high card within the two pair wins. if that is tied, then go to next pair. high card within that 2nd pair wins. if that is tied then go to high card of remaining card. if all tied then that is a draw, winner would be by suit

ONE PAIR VS ONE PAIR
-high card within the one pair wins. if that is tied, then goes to high card of remaining 3 cards. if all 3 remaining cards tied, then that is a draw and winner is by suit.

HIGH CARD VS HIGH CARD 
-high card wins. keep going through cards to next high card. if all tied then that is a draw and winner is by suit. 


SUIT RANK 
spades hearts diamonds clubs

OPTIONS 
1) high card within hand, meaning within the 5 cards of the hand
2) high card within the winning card types, meaning within the four of a kind cards or the 3 cards in full house



=end 

