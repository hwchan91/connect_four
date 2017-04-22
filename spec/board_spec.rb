require "spec_helper"
require "player"
require "board"

describe Board do

  let(:board) {Board.new}

  describe "#row_win?" do
    context "leftmost" do
      it "should return true if there is 4 in a row" do
        [[0,0],[0,1],[0,2],[0,3]].each { |i| board.grid[i[0]][i[1]] = "●" }
        expect(board.row_win?("●")).to be true
      end
    end

    context "middle" do
      it "should return true if there is 4 in a row" do
        [[1,1],[1,2],[1,3],[1,4]].each { |i| board.grid[i[0]][i[1]] = "●" }
        expect(board.row_win?("●")).to be true
      end
    end

    context"rightmost" do
      it "should return true if there is 4 in a row" do
        [[5,3],[5,4],[5,5],[5,6]].each { |i| board.grid[i[0]][i[1]] = "●" }
        expect(board.row_win?("●")).to be true
      end
    end

    context "failure" do
      it "should return false if there is not 4 in a row" do
          [[5,0],[5,1],[5,2],[5,4],[5,5],[5,6]].each { |i| board.grid[i[0]][i[1]] = "●" }
          expect(board.row_win?("●")).to be false
      end
    end
  end


  describe "#col_win?" do
    context "leftmost" do
      it "should return true if there is 4 in a column" do
        [[0,0],[0,1],[0,2],[0,3]].each { |i| board.grid[i[1]][i[0]] = "●" }
        expect(board.col_win?("●")).to be true
      end
    end

    context "middle" do
      it "should return true if there is 4 in a column" do
        [[1,1],[1,2],[1,3],[1,4]].each { |i| board.grid[i[1]][i[0]] = "●" }
        expect(board.col_win?("●")).to be true
      end
    end

    context"rightmost" do
      it "should return true if there is 4 in a column" do
        [[6,3],[6,4],[6,5],[6,2]].each { |i| board.grid[i[1]][i[0]] = "●" }
        expect(board.col_win?("●")).to be true
      end
    end

    context "failure" do
      it "should return false if there is not 4 in a column" do
        [[5,0],[5,1],[5,2],[5,4],[5,5]].each { |i| board.grid[i[1]][i[0]] = "●" }
        expect(board.col_win?("●")).to be false
      end
    end
  end

  describe "#diag_win?" do
    context "lower left to upper right" do
      it "should return true if there is 4 in a diagonal line" do
        [[1,2],[2,3],[3,4],[4,5]].each { |i| board.grid[i[1]][i[0]] = "●" }
        expect(board.diag_win?("●")).to be true
      end
    end

    context "lower right to upper left" do
      it "should return true if there is 4 in a diagonal line" do
        [[1,2],[2,3],[3,4],[4,5]].each { |i| board.grid[i[0]][i[1]] = "●" }
        expect(board.diag_win?("●")).to be true
      end
    end

    context "lower right to upper left" do
      it "should return false if there is not 4 in a diagonal line" do
        [[0,1],[1,2],[2,3],[4,5],[5,6]].each { |i| board.grid[i[0]][i[1]] = "●" }
        expect(board.diag_win?("●")).to be false
      end
    end
  end

  describe "#win?" do
    it "should return true if row_win?, col_win? or diag_win? is true" do
      [[1,2],[2,3],[3,4],[4,5]].each { |i| board.grid[i[0]][i[1]] = "●" }
      expect(board.win?("●")).to be true
    end
  end

  describe "tie?" do
    it "should return true if board if filled and no one wins" do
      board.grid.each do |row|
        row.map!{"X"}
      end
      expect(board.tie?("●")).to be true
    end
  end


end
