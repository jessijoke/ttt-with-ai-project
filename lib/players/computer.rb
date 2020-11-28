require 'pry'

module Players

    class Computer < Player

        def move(board)
            #binding.pry
            ai = [5, 1, 3, 7, 9, 2, 4, 6, 8]
            ai.each { |num| return num.to_s if board.cells[num - 1] }
        end
        
    end

end