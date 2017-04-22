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
        grid[row] << "○"
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
    @grid.none? {|row| row[column] == "○" }
  end

  def insert(column, symbol)
    if !col_full?(column)
      insert_row = @grid.find {|row| row[column] == "○"}
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
