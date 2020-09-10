require_relative 'board'

class Game
    def initialize
        @board = Board.new('O', '#')
    end

    def display
        puts '1 2 3 4 5 6 7'
        for row in @board.board do
            line = ''

            for el in row do
                if el == ' '
                    line += '· ' 
                else
                    line += el
                end
            end

            puts line
        end
    end
end

game = Game.new
game.display