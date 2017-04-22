require_relative "player"
require_relative "board"

class String
  def red;            "\e[31m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
end

class Connect_four
  attr_accessor :board, :player1, :player2, :curr_player

  def initialize
    @board = Board.new
    @player1 = Player.new("Player 1", "●".red)
    @player2 = Player.new("Player 2", "●".brown)
    @curr_player = rand_player
    play
  end

  def rand_player
    rand(2) < 1 ? @player1 : @player2
  end

  def insert(player, column)
    @board.insert(column, player.symbol)
  end

  def switch_player
    @curr_player = (@curr_player == @player1) ? @player2 : @player1
  end

  def end?
    @board.win?(@player1.symbol) or @board.win?(@player2.symbol) or @board.tie?
  end

  def select_col
    while true
      puts "Select column to put #{@curr_player.symbol} coin (1-7)"
      col = gets.chomp
      if !(1..7).to_a.map{|i| i.to_s}.include? col
        puts "Invalid response, please try again."
      elsif @board.col_full?(col.to_i - 1)
        puts "Column #{col.to_1 - 1} is already full."
      else
        break
      end
    end
    col.to_i - 1
  end

  def play
    puts "Game starts. #{@curr_player.name} goes first"
    until end?
      @board.print
      puts "#{@curr_player.name}'s turn.'"
      col = select_col
      insert(@curr_player, col)
      if @board.win?(@curr_player.symbol)
        @board.print
        puts "#{@curr_player.name} wins!"
      elsif @board.tie?
        @board.print
        puts "Game ties. No one wins."
      end
      switch_player
    end
    puts "Another round?"
  end


end
a= Connect_four.new
