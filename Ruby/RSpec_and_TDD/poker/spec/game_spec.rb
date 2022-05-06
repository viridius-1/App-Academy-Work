require 'rspec'
require 'game'

describe Poker do 
    subject(:game) { Poker.new }




    describe '#compare_hands' do 
        it 'ranks a straight flush above four of a kind' do 
        
        end 

        it 'ranks three of a kind below a straight' do 

        end 

        it 'ranks a higher one pair hand over a lower one pair hand' do 

        end 

        it 'ranks equal hands' do 

        end 
    end 

end 

#CARD 
#has symbol
#has value 

#DECK
#has array of all cards
#can deal a specified amount of cards 
#does not retain cards after dealing them 
#can shuffle cards 

#HAND 
#can calculate a hand - pair, full house, etc 

#PLAYER 
#a player has chips 
#context - when game starts 
    #a player can have a hand 
    #player has 5 cards when game starts 
#a player can bet 
#a player can receive chips 
#a player can fold, see the current bet, or raise 
#a player can discard 3 cards, 2 cards, 1 card, or no cards 
#a player can be dealt new cards to replace their old cards
#player is out of game if they fold 
#a player's hand can be revealed 

#GAME
#keeps track of whose turn it is 
#can switch player turns 
#player can no longer take turns if they fold 
#tracks the amount in the pot 
#can compare hands to identify which hand is better 
#gives the winner the pot 
#if there is a draw....
    #it splits the pot if it can be split evenly 
    #if it cant be split evenly, the odd money piece goes by suit rank...from high to low the rank is.....ace, hearts, diamonds, clubs


=begin 
p "\u2660" #spades 
p "\u2663" #clubs 
p "\u2661" #hearts 
p "\u2662" #diamonds

A - 14  
K - 13  
Q - 12 
J - 11 
10 
9 
8 
7 
6 
5 
4 
3 
2 
=end 