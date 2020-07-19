module TicTacToe
  # Game class
  class Game
    attr_reader :game_board, :player1, :player2
    def initialize
      @game_board = GameBoard.new
      @player1 = Player.new(1)
      @player2 = Player.new(2)
    end

    def start
      puts 'RUBY TIC-TAC-TOE'
      puts 'To make a move, type in the number of the position you want to mark and press Enter.'
      loop do
        game_board.print_board
        puts "Player 1's turn:"
        move = get_move
        game_board.mark_position(player1.symbol, move)
        game_board.print_board
        if check_end(game_board.status(1, player1.symbol, move))
          break
        end
        puts "Player 2's turn"
        move = get_move
        game_board.mark_position(player2.symbol, move)
        game_board.print_board
        if check_end(game_board.status(2, player2.symbol, move))
          break
        end
      end
    end

    private
    def get_move
      # Check if 1-9, check if valid. If yes then return move
      move = nil
      loop do
        move = gets.chomp.to_i
        break if move >= 1 && move <= 9 && game_board.valid?(move)
        puts 'Invalid move. Please choose an empty position.'
      end
      move
    end

    def check_end(board_status)
      case board_status
      when 0
        puts 'This game was a draw'
        true
      when 1
        puts 'Player 1 wins!'
        true
      when 2
        puts 'Player 2 wins!'
        true
      else
        false
      end
    end
  end

  # Game board class
  class GameBoard
    def initialize
      @positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    def mark_position(symbol, position)
      @positions[position - 1] = symbol
    end

    def print_board
      puts "\n"
      [0, 3, 6].each do |i|
        puts " #{@positions[i]} | #{@positions[i + 1]} | #{@positions[i + 2]}"
        puts '===+===+===' if i < 6
      end
      puts "\n"
    end

    def valid?(position)
      if @positions[position - 1] != 'X' && @positions[position - 1] != 'O'
        true
      else
        false
      end
    end

    def status(player_number, player_symbol, move)
      if check_vertical(move) || check_horizontal(move) || check_diagonal(move)
        player_number
      elsif all_positions_filled?
        0
      end
    end

    def check_vertical(move)
      case move
      when 1..3
        if @positions[move - 1] == @positions[move + 2] && @positions[move + 2] == @positions[move + 5]
          true
        end
      when 4..6
        if @positions[move - 4] == @positions[move - 1] && @positions[move - 1] == @positions[move + 2]
          true
        end
      when 7..9
        if @positions[move - 7] == @positions[move - 4] && @positions[move - 4] == @positions[move - 1]
          true
        end
      end
    end

    def check_horizontal(move)
      case move
      when 1, 4, 7
        if @positions[move - 1] == @positions[move] && @positions[move] == @positions[move + 1]
          return true
        end
      when 2, 5, 8
        if @positions[move - 2] == @positions[move - 1] && @positions[move - 1] == @positions[move]
          return true
        end
      when 3, 6, 9
        if @positions[move - 3] == @positions[move - 2] && @positions[move - 2] == @positions[move - 1]
          return true
        end
      end
    end

    def check_diagonal(move)
      case move
      when 1, 3, 5, 7, 9
        if (@positions[0] == @positions[4] && @positions[4] == @positions[8]) || (@positions[2] == @positions[4] && @positions[4] == @positions[6])
          true
        else
          false
        end
      else
        false
      end
    end

    def all_positions_filled?
      @positions.all? { |symbol| symbol == 'X' || symbol == 'O' }
    end
  end
  # Player class
  class Player
    attr_reader :symbol, :name
    def initialize(player_number)
      @symbol = set_symbol(player_number)
    end

    def set_symbol(number)
      case number
      when 1
        'X'
      when 2
        'O'
      end
    end
  end
end

game = TicTacToe::Game.new
game.start
