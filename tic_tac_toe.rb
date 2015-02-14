# There is a tic tac toe board. Player selects a spot on grid.
# Than checks to see if Player won. Than computer selects a spot
# on the grid. Again check to see if Computer won. If Player or
# Computer wins, end the game. To win get 3 squares in a row.

require 'pry'
# Board 
#   -squares
#  -all squares marked?
#  -find all empty squares

class Board
  WINNING_COMBOS = [[1,4,7],[2,5,8],[3,6,9],[1,2,3],[4,5,6],[7,8,9],[1,5,9],[7,5,3]]
  def initialize
    @data = {}
    (1..9).each {|position| @data[position] = Square.new(' ')}
  end 

  def draw_board
    puts " "
    puts " #{@data[1].value} | #{@data[2].value} | #{@data[3].value} "
    puts "-----------"
    puts " #{@data[4].value} | #{@data[5].value} | #{@data[6].value} "
    puts "-----------"
    puts " #{@data[7].value} | #{@data[8].value} | #{@data[9].value} "
  end

  def all_squares_marked?
    empty_positions.size == 0
  end

  def empty_positions
    @data.select {|key, square_object| square_object.value == ' '}.keys
  end

  def mark_square(p, marker)
    @data[p].value= marker
  end

  def winning_condition(marker)
    WINNING_COMBOS.each do |row|
      return true if @data[row[0]].value == marker && @data[row[1]].value == marker && @data[row[2]].value == marker
    end
    return false
  end

  def get_data
    @data 
  end
end


class Square
  attr_accessor :value
  def initialize(value)
    @value = value
  end
  # def mark(marker)
  #   @value = marker
  # end

  def occupied?
    @value != ' '
  end
end

class Player
  attr_accessor :name, :marker
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end



class Game

  def initialize
    @board = Board.new
    @human = Player.new("Spirit", "X")
    @computer = Player.new("Bemo", "O")
    @current_player = @human
  end

  def play
    @board.draw_board
    loop do
      current_player_mark_square
      @board.draw_board
      if(current_player_win?)
        puts "The winner is #{@current_player.name}!"
        break
      elsif(@board.all_squares_marked?)
        puts "its a tie!"
        break
      end
      alternate_player
    end

  end

  def current_player_win?
    @board.winning_condition(@current_player.marker)
  end

  def picked_empty_spot(position)
    @board.get_data[position].occupied?
  end



  def current_player_mark_square
    if(@current_player==@human)
      begin
        print "Pick a spot to mark(1-9): "
        position = gets.chomp.to_i
      end until picked_empty_spot(position) == false
    else
      position = @board.empty_positions.sample
    end
    @board.mark_square(position, @current_player.marker)
  end

  def alternate_player
    if(@current_player == @human)
      @current_player = @computer
    else
      @current_player = @human
    end
  end
end

Game.new.play
















