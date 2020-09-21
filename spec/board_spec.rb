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
        it "returns O if 4 player pieces connect horizontally (XOOOOXX)" do
            game = Board.new('O', 'X')
            board = game.board
            board[rand(0..5)] = ['X', 'O', 'O', 'O', 'O', 'X', 'X']

            expect(game.horizontal_win?).to eql('O')
        end

        it "returns X if 4 player pieces connect horizontally (XOOXXXX)" do
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
        it "returns O if 4 player pieces connect vertically (OOOOXO)" do
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

        it "returns O if 4 player pieces connect vertically (OXOOOO)" do
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
                
                expect(game.diagonal_win?).to eql('O')

                # reset board

                for y in 0..board.length-1
                    for x in 0..board[y].length-1
                        board[y][x] = " "
                    end
                end
            end
        end

        it "returns X if 4 player pieces connect diagonally from bottom left to top right (XXXX)" do
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
                    board[y][x] = 'X'
                    y -= 1
                    x += 1
                end
                
                expect(game.diagonal_win?).to eql('X')

                # reset board

                for y in 0..board.length-1
                    for x in 0..board[y].length-1
                        board[y][x] = " "
                    end
                end
            end
        end

        it "returns false if no 4 player pieces connect diagonally" do
            game = Board.new('O', 'X')
            board = game.board

            start_points = [
                [2,0], [2,1], [2,2], [2,3]
            ]

            for arr in start_points
                y, x = arr
                max_y = y - 4
                max_x = x + 4

                # fill coordinates in board from starting point to end

                until y == max_y && x == max_x
                    board[y][x] = 'X'
                    y -= 1
                    x += 1
                end
                
                expect(game.diagonal_win?).to eql(false)

                # reset board

                for y in 0..board.length-1
                    for x in 0..board[y].length-1
                        board[y][x] = " "
                    end
                end
            end
        end
    end

    describe "#drop_piece?" do
        it "returns false if the inputted number is < 1 and > 7" do
            game = Board.new('O', 'X')

            expect(game.drop_piece?(-1, 'O')).to eql(false)
            expect(game.drop_piece?(0, 'X')).to eql(false)
            expect(game.drop_piece?(8, 'O')).to eql(false)
            expect(game.drop_piece?(10, 'X')).to eql(false)
        end

        # several tests below use the same subject
        subject { Board.new('O', 'X') }

        it "returns true since the position is available, player piece (O) is on the bottom of the board" do
            expect(subject.drop_piece?(3, 'O')).to eql(true)
            expect(subject.board[5][2]).to eql('O')
        end

        it "returns true since the position is available, player piece (X) is on top of another piece" do
            expect(subject.drop_piece?(3, 'O')).to eql(true)
            expect(subject.drop_piece?(3, 'X')).to eql(true)

            expect(subject.board[5][2]).to eql('O')
            expect(subject.board[4][2]).to eql('X')
        end

        it "pieces are where they're supposed to be on the board" do
            expect(subject.drop_piece?(3, 'O')).to eql(true)
            expect(subject.drop_piece?(3, 'X')).to eql(true)
            expect(subject.drop_piece?(4, 'O')).to eql(true)
            expect(subject.drop_piece?(5, 'X')).to eql(true)
            expect(subject.drop_piece?(2, 'O')).to eql(true)
            expect(subject.drop_piece?(1, 'X')).to eql(true)
            expect(subject.drop_piece?(4, 'O')).to eql(true)
            expect(subject.drop_piece?(2, 'X')).to eql(true)
            expect(subject.drop_piece?(4, 'O')).to eql(true)
            expect(subject.drop_piece?(4, 'X')).to eql(true)
            expect(subject.drop_piece?(3, 'O')).to eql(true)
            expect(subject.drop_piece?(5, 'X')).to eql(true)
            expect(subject.drop_piece?(2, 'O')).to eql(true)
            expect(subject.drop_piece?(5, 'X')).to eql(true)
            expect(subject.drop_piece?(5, 'O')).to eql(true)
            expect(subject.drop_piece?(6, 'X')).to eql(true)
            expect(subject.drop_piece?(1, 'O')).to eql(true)
            expect(subject.drop_piece?(1, 'X')).to eql(true)
            expect(subject.drop_piece?(7, 'O')).to eql(true)
            expect(subject.drop_piece?(6, 'X')).to eql(true)
            expect(subject.drop_piece?(2, 'O')).to eql(true)
            expect(subject.drop_piece?(6, 'X')).to eql(true)
            expect(subject.drop_piece?(6, 'O')).to eql(true)
            expect(subject.drop_piece?(6, 'X')).to eql(true)
            expect(subject.drop_piece?(1, 'O')).to eql(true)
            expect(subject.drop_piece?(1, 'X')).to eql(true)
            expect(subject.drop_piece?(2, 'O')).to eql(true)
            expect(subject.drop_piece?(2, 'X')).to eql(true)

            expect(subject.board[5][2]).to eql('O')
            expect(subject.board[4][2]).to eql('X')
            expect(subject.board[5][3]).to eql('O')
            expect(subject.board[5][4]).to eql('X')
            expect(subject.board[5][1]).to eql('O')
            expect(subject.board[5][0]).to eql('X')
            expect(subject.board[4][3]).to eql('O')
            expect(subject.board[4][1]).to eql('X')
            expect(subject.board[3][3]).to eql('O')
            expect(subject.board[2][3]).to eql('X')
            expect(subject.board[3][2]).to eql('O')
            expect(subject.board[4][4]).to eql('X')
            expect(subject.board[3][1]).to eql('O')
            expect(subject.board[3][4]).to eql('X')
            expect(subject.board[2][4]).to eql('O')
            expect(subject.board[5][5]).to eql('X')
            expect(subject.board[4][0]).to eql('O')
            expect(subject.board[3][0]).to eql('X')
            expect(subject.board[5][6]).to eql('O')
            expect(subject.board[5][4]).to eql('X')
            expect(subject.board[2][1]).to eql('O')
            expect(subject.board[3][5]).to eql('X')
            expect(subject.board[5][2]).to eql('O')
            expect(subject.board[1][5]).to eql('X')
            expect(subject.board[2][0]).to eql('O')
            expect(subject.board[1][0]).to eql('X')
            expect(subject.board[1][1]).to eql('O')
            expect(subject.board[0][1]).to eql('X')
        end

        it "returns false when a move is invalid" do
            subject.board = [
                [" ", "X", " ", " ", " ", " ", " "],
                ["X", "O", " ", " ", " ", "X", " "],
                ["O", "O", " ", "X", "O", "O", " "],
                ["X", "O", "O", "O", "X", "X", " "],
                ["O", "X", "X", "O", "X", "X", " "],
                ["X", "O", "O", "O", "X", "X", "O"]
            ]

            expect(subject.drop_piece?(2, 'O')).to eql(false)

            pp subject.board
        end
    end
end