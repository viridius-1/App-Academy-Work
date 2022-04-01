class WordChainer 

    attr_reader :all_seen_words

    def initialize(dictionary)
        @dictionary = (File.readlines(dictionary).map do |dictionary_word| 
            if dictionary_word.include?("\n") 
                dictionary_word.delete!("\n")
            else 
                dictionary_word 
            end 
        end).to_set
        @all_seen_words = nil
    end 

    #returns all words in dictionary that have the same length as word and only differ by one letter
    def get_adjacent_words(word)
        adjacents = []
        @dictionary.each { |dictionary_word| adjacents << dictionary_word if word.length == dictionary_word.length && differs_by_one_letter?(word, dictionary_word) }
        adjacents 
    end 

    #returns a boolean of whether a word differs from a word of equal length by 1 letter 
    def differs_by_one_letter?(word, dictionary_word)
        differences = 0 

        idx = 0 
        while idx < word.length 
            differences += 1 if word[idx] != dictionary_word[idx] 
            return false if differences > 1 
            idx += 1 
        end 

        return true if differences == 1  
    end 

    def run(source, target)
        @current_words = [source]
        @all_seen_words = { source => nil }
        
        until @all_seen_words.has_key?(target)
            @current_words, @all_seen_words = explore_current_words(@current_words, @all_seen_words, target)
        end 

        puts "Word Chain = #{build_path(target)}" 
    end 

    #builds word changes 
    def explore_current_words(current_words, all_seen_words, target)
        new_current_words = []

        current_words.each do |current_word| 
            adjacent_words = get_adjacent_words(current_word)
            adjacent_words.each do |adjacent_word| 
                if !all_seen_words.include?(adjacent_word)
                    new_current_words << adjacent_word
                    all_seen_words[adjacent_word] = current_word
                    return [new_current_words, all_seen_words] if adjacent_word == target 
                end 
            end 
        end

        [new_current_words, all_seen_words]
    end 

    #builds final word chain 
    def build_path(target)
        path = [target]

        until @all_seen_words[target] == nil 
            prev_word = @all_seen_words[target]
            path << prev_word 
            target = prev_word 
        end 

        path.reverse  
    end 

end 

