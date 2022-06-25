require_relative 'display'
require_relative 'human_player'
require 'byebug'

class Game 

    attr_reader :board, :current_player, :display, :player1, :player2
    attr_accessor :starting_piece 

    def initialize(name1, name2)
        introduction 
        @board = Board.new
        @display = Display.new(board)
        @starting_piece = nil 
        @player1 = HumanPlayer.new(name1, :white)
        @player2 = HumanPlayer.new(name2, :black) 
        @current_player = player1 
    end 

    def play 
        until board.checkmate?(current_player.color)
            move_complete = false 
            while !move_complete
                start_position = get_start_position 
                @starting_piece = board[start_position.first, start_position.last] 
                end_position = get_cursor_selection(select_position_prompt)
                next if end_position == start_position
                print_board
                move_complete = true if board.move_piece(start_position, end_position) 
            end 
            check_prompt
            swap_turn
        end 
        result
    end 

    private 

    def introduction 
        puts "Welcome to Chess!"
        puts "For chess instructions, please visit https://en.wikipedia.org/wiki/Rules_of_chess"
        puts "Use space or enter to select pieces and squares."
        puts "Press return/enter to begin."
        gets 
    end 

    def select_piece_prompt 
        "#{current_player.name}, select a piece."
    end 

    def select_position_prompt
        "#{current_player.name}, select a square to move the #{starting_piece.color.capitalize} #{starting_piece.class}."
    end 

    def check_prompt
        puts "#{current_player.color.capitalize} is in check." if board.in_check?(current_player.color)
    end 

    #method lets player move cursor through board until they hit enter or space 
    def get_cursor_selection(prompt)
        valid_cursor_selection = false

        while !valid_cursor_selection
            print_board
            check_prompt
            puts prompt
            cursor_selection = current_player.make_move(display) 
            valid_cursor_selection = true if cursor_selection.is_a?(Array)
        end 

        cursor_selection
    end 

    #method returns the starting position of a piece 
    def get_start_position  
        valid_start = false 
 
        while !valid_start
            start_position = get_cursor_selection(select_piece_prompt)

            if board.null_piece?(start_position.first, start_position.last)
                print_board
                puts "That is not a piece."
                display.cursor.toggle_selected
                board.prompt_to_continue_move
            elsif board.piece_color(start_position) != current_player.color
                print_board
                puts "That isn't your color. Please select a #{current_player.color.capitalize} piece."
                display.cursor.toggle_selected
                board.prompt_to_continue_move
            else 
            #elsif !board.null_piece?(start_position.first, start_position.last)  
                valid_start = true   
            end 
        end 

        start_position
    end

    def other_player(player)
        player == player1 ? player2 : player1 
    end 

    def swap_turn 
        @current_player = other_player(current_player)
    end 

    def result 
        winner = other_player(current_player)
        loser = current_player 
        print_board
        puts "#{loser.color.capitalize} is in checkmate. #{winner.name} wins. #{loser.name} loses."
    end 

    def print_board 
        clear
        display.render 
    end 

    def clear 
        system("clear")
    end 

end 

g = Game.new('Jake', 'Ann')
g.play