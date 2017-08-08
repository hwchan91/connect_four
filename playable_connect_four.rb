class String
  def red;            "\e[31m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
end

class Player
  attr_accessor :name, :symbol

  def initialize(text, symbol)
    puts text
    @name = gets.chomp
    @symbol = symbol
  end

end

class Board
  attr_accessor :grid

  def initialize
    @grid = empty_grid
  end

  def empty_grid
    grid = []
    6.times do |row|
      grid << []
      7.times do
        grid[row] << "○ "
      end
    end
    grid
  end

  def print
    reverse_rows = @grid.reverse
    puts "   1  2  3  4  5  6  7"
    puts " ----------------------"
    6.times { |i| puts "| #{reverse_rows[i].join(" ")} |" }
    puts " ----------------------"
  end

  def col_full?(column)
    @grid.none? {|row| row[column] == "○ " }
  end

  def insert(column, symbol)
    if !col_full?(column)
      insert_row = @grid.find {|row| row[column] == "○ "}
      insert_row[column] = symbol
    end
  end

  def row_win?(symbol)
    win = false
    @grid.each do |row|
      4.times do |i|
        win = true if (0..3).to_a.all? { |j| row[i+j] == symbol }
      end
    end
    win
  end

  def col_win?(symbol)
    win = false
    7.times do |column|
      3.times do |i|
        win = true if (0..3).to_a.all? {|row| @grid[row + i][column] == symbol }
      end
    end
    win
  end

  def diag_win?(symbol)
    win = false
    3.times do |k|
      4.times do |j|
        win = true if (0..3).to_a.all? {|i| @grid[i+k][i+j] == symbol }
        win = true if (0..3).to_a.all? {|i| @grid[i+k][(3-i)+j] == symbol }
      end
    end
    win
  end

  def win?(symbol)
    row_win?(symbol) or col_win?(symbol) or diag_win?(symbol)
  end

  def tie?
    (0..6).to_a.all? { |i| col_full?(i) }
  end

end

class Connect_four
  attr_accessor :board, :player1, :player2, :curr_player

  def initialize
    @board = Board.new
    @player1 = Player.new("What is player 1's name?", "● ".red)
    @player2 = Player.new("What is player 2's name?", "● ".brown)
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
        puts "Column #{col.to_i - 1} is already full."
      else
        break
      end
    end
    col.to_i - 1
  end

  def play
    puts "Game starts. #{@curr_player.name} goes first."
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
