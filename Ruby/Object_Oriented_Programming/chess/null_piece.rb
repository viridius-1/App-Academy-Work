require_relative 'piece'
require 'singleton'

class NullPiece < Piece 

    include Singleton 

    def initialize
        # set_color 
        # set_symbol
    end 

end 