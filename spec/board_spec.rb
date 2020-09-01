require '../lib/board.rb'

describe Board do
    describe "@board" do
        it "has height of 6 blocks and width of 7 blocks" do
            board = Board.new('O', 'X').board

            expect(board.length).to eql(6)
            expect(board[rand(0..5)].length).to eql(7)
        end
    end
    
    describe "#horizontal_win?" do
        it "returns `winner` if 4 player pieces connect horizontally (XOOOOXX)" do
            game = Board.new('O', 'X')
            board = game.board
            board[rand(0..5)] = ['X', 'O', 'O', 'O', 'O', 'X', 'X']

            expect(game.horizontal_win?).to eql('O')
        end

        it "returns `winner` if 4 player pieces connect horizontally (XOOXXXX)" do
            game = Board.new('O', 'X')
            board = game.board
            board[rand(0..5)] = ['X', 'O', 'O', 'X', 'X', 'X', 'X']

            expect(game.horizontal_win?).to eql('X')
        end

        it "returns false if no 4 player pieces connect horizontally (XOXOOXX)" do
            game = Board.new('O', 'X')
            board = game.board
            board[rand(0..5)] = ['X', 'O', 'X', 'O', 'O', 'X', 'X']

            expect(game.horizontal_win?).to eql(false)
        end
    end

    describe "#vertical_win?" do
        it "returns `winner` if 4 player pieces connect vertically (OOOOXO)" do
            game = Board.new('O', 'X')
            board = game.board
            rand = rand(0..6)

            for i in 0..board.length-3
                board[i][rand] = 'O'
            end

            board[board.length-2][rand] = 'X'
            board[board.length-1][rand] = 'O'

            expect(game.vertical_win?).to eql('O')
        end

        it "returns `winner` if 4 player pieces connect vertically (OXOOOO)" do
            game = Board.new('O', 'X')
            board = game.board
            rand = rand(0..6)

            for i in 2..board.length-1
                board[i][rand] = 'O'
            end

            board[0][rand] = 'O'
            board[1][rand] = 'X'

            expect(game.vertical_win?).to eql('O')
        end

        it "returns false if no 4 player pieces connect vertically (OXOOOX)" do
            game = Board.new('O', 'X')
            board = game.board
            rand = rand(0..6)

            for i in 2..board.length-2
                board[i][rand] = 'O'
            end

            board[0][rand] = 'O'
            board[1][rand] = 'X'

            expect(game.vertical_win?).to eql(false)
        end
    end

    describe "#diagonal_win?" do
        it "returns O if 4 player pieces connect diagonally from top left to bottom right (OOOO)" do
            game = Board.new('O', 'X')
            board = game.board

            start_points = [
                [0,0], [1,0], [2,0],
                [0,1], [1,1], [2,1],
                [0,2], [1,2], [2,2],
                [0,3], [1,3], [2,3]
            ]

            for arr in start_points
                y, x = arr
                max_y = y + 4
                max_x = x + 4

                # fill coordinates in board from starting point to end

                until y == max_y && x == max_x
                    board[y][x] = 'O'
                    y += 1
                    x += 1
                end
                
                expect(game.diagonal_win?).to eql('O')

                # reset board

                for y in 0..board.length-1
                    for x in 0..board[y].length-1
                        board[y][x] = " "
                    end
                end
            end
        end

        it "returns X if 4 player pieces connect diagonally from top left to bottom right (XXXX)" do
            game = Board.new('O', 'X')
            board = game.board

            start_points = [
                [0,0], [1,0], [2,0],
                [0,1], [1,1], [2,1],
                [0,2], [1,2], [2,2],
                [0,3], [1,3], [2,3]
            ]

            for arr in start_points
                y, x = arr
                max_y = y + 4
                max_x = x + 4

                # fill coordinates in board from starting point to end

                until y == max_y && x == max_x
                    board[y][x] = 'X'
                    y += 1
                    x += 1
                end

                pp board
                
                expect(game.diagonal_win?).to eql('X')

                # reset board

                for y in 0..board.length-1
                    for x in 0..board[y].length-1
                        board[y][x] = " "
                    end
                end
            end
        end

        it "returns O if 4 player pieces connect diagonally from bottom left to top right (OOOO)" do
            game = Board.new('O', 'X')
            board = game.board

            start_points = [
                [5,0], [4,0], [3,0],
                [5,1], [4,1], [3,1],
                [5,2], [4,2], [3,2],
                [5,3], [4,3], [3,3]
            ]

            for arr in start_points
                y, x = arr
                max_y = y - 4
                max_x = x + 4

                # fill coordinates in board from starting point to end

                until y == max_y && x == max_x
                    board[y][x] = 'O'
                    y -= 1
                    x += 1
                end

                pp board
                pp ""
                
                # expect(game.diagonal_win?).to eql('O')

                # reset board

                for y in 0..board.length-1
                    for x in 0..board[y].length-1
                        board[y][x] = " "
                    end
                end
            end
        end
    end
end