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
        it "returns true if 4 player1/player2 pieces connect horizontally" do
            game = Board.new('O', 'X')
            board = game.board
            board[rand(0..5)] = ['X', 'O', 'O', 'O', 'O', 'X', 'X']

            expect(game.horizontal_win?).to eql(true)
        end

        it "returns false if 4 player1/player2 pieces don't connect horizontally" do
            game = Board.new('O', 'X')
            board = game.board
            board[rand(0..5)] = ['X', 'O', 'X', 'O', 'O', 'X', 'X']

            expect(game.horizontal_win?).to eql(false)
        end
    end

    # describe "#vertical_win?" do
    #     it "re"
end