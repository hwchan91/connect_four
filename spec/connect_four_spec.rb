require "spec_helper"
require "player"
require "board"
require "connect_four"

describe Connect_four do
  let(:game) {Connect_four.new}

  describe "initialize" do
    it "sets up board and players" do
      expect(game.board).to be_a(Board)
      expect(game.player1).to be_a(Player)
      expect(game.player2).to be_a(Player)
    end
  end

  describe "#rand_player" do
    it "should randomly select a player to go first" do
      first = []
      10.times { first << game.rand_player }
      expect(first.all? {|player| player.is_a? Player }).to be true
      expect(first.all? {|player| player == first[0] }).to be false
    end
  end

  describe "#insert" do
    it "should add symbol in selected column" do
      expect(game.board.grid[0][0]).to eql("○")
      game.insert(game.player1, 0)
      expect(game.board.grid[0][0]).to eql(game.player1.symbol)
      game.insert(game.player1, 0)
      expect(game.board.grid[1][0]).to eql(game.player1.symbol)
    end
  end

  describe "#switch_player" do
    it "should switch @curr_player" do
      curr_player = game.curr_player
      game.switch_player
      expect(game.curr_player).to_not eql(curr_player)
      game.switch_player
      expect(game.curr_player).to eql(curr_player)
    end
  end

  describe "#end?" do
    it "should return true if sb wins" do
      4.times {game.insert(game.player1, 0)}
      expect(game.end?(game.player1.symbol)).to be true
    end

    it "should return true if game ties" do
      7.times {|i| 6.times {game.insert(game.player1, i)} }
      expect(game.end?(game.player1.symbol)).to be true
    end
  end




end
