require "byebug"

class AiPlayer 

    attr_reader :name 

    def initialize 
        @name = 'Computer'
    end 

    def guess(fragment, dictionary, player_ct) 
        alphabet = 'abcdefghijklmnopqrstuvwxyz'
        winning_moves = []
        losing_moves = []

        alphabet.each_char do |ltr| 
            poss_fragment = fragment + ltr 
            
            #find losing moves 
            dictionary.each_key do |word| 
                if word == poss_fragment 
                    losing_moves << ltr 
                    break
                end 
            end 

            #find winning moves 
            dictionary.each_key do |word| 
                if word[0..poss_fragment.length - 1] == poss_fragment && (word.length - poss_fragment.length) % (player_ct + 1) != 0 && !losing_moves.include?(ltr)
                    winning_moves << ltr  
                    break
                end     
            end 
        end 
        
        possible_words = get_possible_words(fragment, winning_moves, dictionary) #get hash of words that could be made with a possible move 
        possible_moves_tree = get_possible_moves_tree(possible_words, player_ct, fragment) #get hash tree of possible moves 
        sorted_moves = possible_moves_tree.sort_by { |move, data| data.last } #sort by difference of count of winning words by move - count of losing words by move
        
        return losing_moves.sample if winning_moves.empty? 
        sorted_moves[-1][0]
    end 

    #method returns array of words that could be made with a possible move 
    def get_possible_words(fragment, winning_moves, dictionary)
        possible_words = Hash.new { |hash, key| hash[key] = [] }

        winning_moves.each do |move| 
            poss_fragment_with_move = fragment + move   
            dictionary.each_key { |word| possible_words[move] << word if word[0..poss_fragment_with_move.length - 1] == poss_fragment_with_move } 
        end 

        possible_words
    end 

    #method returns hash of a tree of possible moves. each move set to array. first value is count of winning words from move. second value is count of losing words from move. last value set to the difference(winning - losing). 
    def get_possible_moves_tree(possible_words, player_ct, fragment)
        possible_moves_tree = {}

        possible_words.each do |ltr, words| 
            possible_fragment = fragment + ltr
            winners = 0 
            losers = 0 
            words.each do |word| 
                remaining_letters_after_fragment = word.length - possible_fragment.length
                if remaining_letters_after_fragment <= player_ct
                    winners += 1 
                elsif remaining_letters_after_fragment % (player_ct + 1) == 0 
                    losers += 1 
                else      
                    winners += 1 
                end 
                possible_moves_tree[ltr] = [winners, losers, winners - losers]
            end 
        end 
            
        possible_moves_tree
    end 

end 