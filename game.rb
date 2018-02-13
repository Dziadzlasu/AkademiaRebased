require 'pry'
require 'pry-nav'
class Game
  attr_accessor :board, :win, :field, :turn

  def initialize
    @win = false
    @board = { A1: ' ', A2: ' ', A3: ' ', B1: ' ', B2: ' ', B3: ' ', C1: ' ', C2: ' ', C3: ' ' }
  end

  def draw
    puts ' -------------'
    puts "3| #{board[:A3]} | #{board[:B3]} | #{board[:C3]} |"
    puts ' -------------'
    puts "2| #{board[:A2]} | #{board[:B2]} | #{board[:C2]} |"
    puts ' -------------'
    puts "1| #{board[:A1]} | #{board[:B1]} | #{board[:C1]} |"
    puts ' -------------'
    puts '   A   B   C'
  end

  def winner(row)
    return if row.any? { |s| s.strip.empty? }
    return unless row.uniq.length == 1
    puts "#{row.first} wins!"
    @win = true
  end

  def check_winner
    [[board[:A1], board[:B1], board[:C1]],
     [board[:A2], board[:B2], board[:C2]],
     [board[:A3], board[:B3], board[:C3]],
     [board[:A1], board[:A2], board[:A3]],
     [board[:B1], board[:B2], board[:B3]],
     [board[:C1], board[:C2], board[:C3]],
     [board[:A1], board[:B2], board[:C3]],
     [board[:A3], board[:B2], board[:C1]]].detect { |comb| winner(comb) }
  end

  def add_symbol(field, player)
    board[field] = player
  end

  def player_input(turn)
    draw
    @player = 'X' if turn.odd?
    @player = 'O' if turn.even?
    puts "Choose empty field for next #{@player} move"
    # binding.pry
    @field = gets.chomp.upcase.to_sym
    # binding.pry
  end

  def game_logic
    turn = 1
    loop do
      player_input(turn)
      # binding.pry
      if board.key?(field)
        if board[field].strip.empty?
        add_symbol(field, @player)
        turn += 1
        end
        draw
        break if win == true
        break if turn == 10 && !check_winner
        break if check_winner
      else
        puts 'Please input valid field number e.g. "A1"'
      end
    end
  end
end
Game.new.game_logic
