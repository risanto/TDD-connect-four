require_relative 'board'

class Object
    def values_at(*attributes)
      attributes.map { |attribute| send(attribute) }
    end
end

class Game
    def initialize
        @game = Board.new('O', '#')
        @board, @player1, @player2, @last_player = @game.values_at(:board, :player1, :player2, :last_player)
        @theres_winner = false
    end

    def display
        puts ""
        puts '1 2 3 4 5 6 7'
        for row in @board do
            line = ''

            for el in row do
                if el == ' '
                    line += '· ' 
                else
                    line += el + ' '
                end
            end

            puts line
        end
        puts ""
    end

    def play
        until @game.theres_winner? == true do
            system("clear") || system("cls")
            
            display
    
            if @last_player == nil
                @last_player = @player1
            elsif @last_player == @player1
                @last_player = @player2
            elsif @last_player == @player2
                @last_player = @player1
            end

            puts "It's #{@last_player} turn. Pick where to drop your piece."
    
            n = gets.chomp.to_i
    
            @game.drop_piece?(n, @last_player)
    
            display
        end

        system("clear") || system("cls")
        display

        puts "Congrats, #{@last_player} won the game!"
    end  
end

game = Game.new
game.play