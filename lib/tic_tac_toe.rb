class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 4, 8],
    [2, 4, 6],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]

  attr_accessor :board

  def initialize( board = Array.new(9, " ") )
    @board = board

  end

  def display_board
    i = 0

    3.times do
      puts " #{@board[i]} | #{@board[i + 1]} | #{@board[i + 2]} "
      i += 3
      puts "-----------" if i < 7
    end

  end

  def input_to_index(str)
    str.to_i - 1
  end

  def move(square, player_symbol = "X")
    @board[square] = player_symbol unless position_taken?(square)
  end

  def position_taken?(square)
    @board[square] != " "
  end

  def valid_move?(square)
    @board[square] == " " && (0..9).include?(square)
  end

  def turn_count
    @board.filter{ |square| square != " " }.length
  end

  def current_player
    self.turn_count.even? ? "X" : "O"
  end

  def turn
    player = self.current_player

    print "#{ player }, choose a square(1-9): "
    
    move = gets.chomp
    index = input_to_index( move )

    if valid_move?( index )
      move( index, player )
      display_board
    else
      puts "Invalid Move\n\n"
      self.turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if (
        self.board[combo[0]] == "X" &&
        self.board[combo[1]] == "X" &&
        self.board[combo[2]] == "X" ||

        self.board[combo[0]] == "O" &&
        self.board[combo[1]] == "O" &&
        self.board[combo[2]] == "O"
      )
        return *combo
      end
    end
    return false
  end

  def full?
    self.board.none? { |square| square == " " }
  end

  def draw?
    !self.won? && self.full?
  end

  def over?
    self.won? || self.draw?
  end

  def winner
    if self.won?
      self.current_player == "X" ? "O" : "X"
    end
  end

end
# binding.pry

# game = TicTacToe.new(["O", "O", " ", "X", "X", "X", " ", " ", " "])
# print game.winner