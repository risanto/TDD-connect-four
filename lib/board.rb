class Board
    attr_accessor :board, :player1, :player2, :last_player

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

            for row in cons4
                return row[0] if row[0] != " " && row.all? {|a| a == row[0]}
            end
        end

        false
    end

    def vertical_win?
        for i in 0..@board[0].length-1

            # Check whether all of the consecutive 4 vertical elements is equal to each other and are not empty
            
            count1 = 0
            count2 = 0

            previous = nil

            for j in 0..@board.length-1
                if @board[j][i] != " "
                    if previous == nil || previous != @board[j][i]
                        previous = @board[j][i]

                        count1 = 0
                        count2 = 0

                        count1 += 1 if previous == @player1
                        count2 += 1 if previous == @player2
                        next
                    end

                    if previous == @player1
                        @board[j][i] == previous ? count1 += 1 : count1 = 0
                    elsif previous == @player2
                        @board[j][i] == previous ? count2 += 1 : count2 = 0
                    end

                    if count1 >= 4
                        return @player1
                    elsif count2 >= 4
                        return @player2
                    end
                end
            end
        end

        false
    end

    def diagonal_win?
        '''
        Check whether all of the consecutive 4 diagonal elements is equal to each other and are not empty
        
        Starting points for diagonal lines that start from top left:
        [0,0] [1,0] [2,0]
        [0,1] [1,1] [2,1] 
        [0,2] [1,2] [2,2]
        [0,3] [1,3] [2,3]

        Starting points for diagonal lines that start from bottom left:
        [5,0], [4,0], [3,0]
        [5,1], [4,1], [3,1]
        [5,2], [4,2], [3,2]
        [5,3], [4,3], [3,3]
        '''

        top_left_start_points = [
            [0,0], [1,0], [2,0],
            [0,1], [1,1], [2,1],
            [0,2], [1,2], [2,2],
            [0,3], [1,3], [2,3]
        ]

        for arr in top_left_start_points
            cons4 = []

            y, x = arr
            max_y = y + 4
            max_x = x + 4

            until y == max_y && x == max_x
                cons4 << @board[y][x]

                # go down diagonally in every move until it reaches bottom left
                y += 1
                x += 1
            end

            # return the first content if every element inside the array is the same
            return cons4[0] if cons4[0] != " " && cons4.all? {|a| a == cons4[0]}
        end

        btm_left_start_points = [
            [5,0], [4,0], [3,0],
            [5,1], [4,1], [3,1],
            [5,2], [4,2], [3,2],
            [5,3], [4,3], [3,3]
        ]

        for arr in btm_left_start_points
            cons4 = []

            y, x = arr
            max_y = y - 4
            max_x = x + 4

            until y == max_y && x == max_x
                cons4 << @board[y][x]

                # go up diagonally in every move until it reaches top right
                y -= 1
                x += 1
            end

            # return the first content if every element inside the array is the same
            return cons4[0] if cons4[0] != " " && cons4.all? {|a| a == cons4[0]}
        end

        false
    end

    def theres_winner?
        return true if horizontal_win? != false || vertical_win? != false || diagonal_win? != false

        return false
    end

    def drop_piece?(n, piece)
        return false if n < 1 || n > 7

        column = []
        
        y = -1
        x = n

        for i in 0..@board.length-1
            break if @board[i][n-1] != " "

            y = i
            x = n-1

            column << @board[i][n-1]
        end

        return false if y == -1

        @board[y][x] = piece

        return true
    end
end