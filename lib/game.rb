require 'pry'
require_relative './board.rb'

class Game < Board
    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
        [0, 1, 2], #top across
        [3, 4, 5], #middle across
        [6, 7, 8], #bottom across 
        [0, 3, 6], #first column
        [1, 4, 7], #middle column
        [2, 5, 8], #last column
        [0, 4, 8], #top to bottom \
        [6, 4, 2] #bottom to top /
    ]

    def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new)
        @player_1 = player_1 
        @player_2 = player_2
        @board = board
    end

    def current_player
        @board.turn_count % 2 == 0 ? @player_1 : @player_2
    end

    def won?
        WIN_COMBINATIONS.find do |win_combo|
            @values = @board.cells.values_at(*win_combo)
            @values.all?('X') || @values.all?('O')
        end
    end

    def draw?
        !won? && @board.turn_count == 9
    end

    def over? 
        (won? || draw?) ? true : false
    end

    def winner
        @board.cells[won?[0]] if won?
    end

    def turn
        puts "Please choose a number 1-9:"
        player = current_player
        current_move = player.move(@board)
        if !@board.valid_move?(current_move)
            turn
        else
            puts "Turn: #{@board.turn_count+1}\n"
            @board.display
            @board.update(current_move, player)
            puts "#{player.token} moved #{current_move}"
            @board.display
            puts "\n\n"
        end
    end

    def play
        turn until over?
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
                
    end

end

