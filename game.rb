class Game
  attr_accessor :board
  attr_accessor :win

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
    if row.uniq.length == 1
      puts "#{row.first} wins!"
      @win = true
    end
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

  def add_symbol(field, symbol)
    board[field] = symbol
  end

  def player_input
    draw
    turn = 1
    while win == false
      if turn.odd?
        puts 'Choose empty field for next X move'
        field = gets.chomp.upcase.to_sym
        if board.key?(field)
          if board[field].strip.empty?
            add_symbol(field, 'X')
            turn += 1
          end
          draw
          break if board.all? { |_k, v| !v.strip.empty? } && !check_winner
          break if check_winner
        else
          puts 'Please input valid field number e.g. "A1"'
        end
      else
        puts 'Choose empty field for next O move'
        field = gets.chomp.upcase.to_sym
        if board.key?(field)
          if board[field].strip.empty?
            add_symbol(field, 'O')
            turn += 1
          end
          draw
          break if board.all? { |_k, v| !v.strip.empty? } && !check_winner
          break if check_winner
        else
          puts 'Please input valid field number e.g. "A1"'
        end
      end
    end
  end
end
Game.new.player_input
