class Board
    attr_accessor :board

    def initialize(player1, player2)
        @board = Array.new(6) {Array.new(7, ' ')}
        @player1 = player1
        @player2 = player2
        @last_player = nil
    end

    def horizontal_win?
        for i in 0..@board.length-1

            # Check whether all of the consecutive 4 elements inside an array is equal to each other and are not empty

            cons4 = @board[i].each_cons(4).to_a

            for arr in cons4
                return true if arr[0] != " " && arr.all? {|a| a == arr[0]}
            end
        end

        false
    end
end