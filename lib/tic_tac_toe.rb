def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
  
def input_to_index(user_input)
   user_input.to_i - 1
end
  
def move(board, index, cplayer = current_player(board))
    board[index] = cplayer
end
  
def position_taken?(board, location)
    board[location] != " " && board[location] != ""
end
  
def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
end
  
def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index)
      display_board(board)
    else
      turn(board)
    end
end
  
def play(board)
    until over?(board) == true
        turn(board)
    end
    if draw?(board) == true
        puts "Cat's Game!"
    else won?(board) != false
        if winner(board) == "X"
            puts "Congratulations X!"
        else
            puts "Congratulations O!"
        end
    end
end

def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
end
  
WIN_COMBINATIONS = [
    [0,1,2], #top row win
    [3,4,5], # middle row win
    [6,7,8], #bottom row win
    [0,4,8], #diag left-right win
    [2,4,6], #diag right-left win
    [0,3,6], #left col win
    [1,4,7], #middle col win
    [2,5,8] #right col win
]
  
def won?(board)
    #iterate win combos
    WIN_COMBINATIONS.each do |combo|
      if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
        return combo
      elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
        return combo
      else
        false
      end
    end
    false
end
  
def full?(board)
    if board.detect{|pos| pos == " "}
      return false
    else
      return true
    end
end
  
def draw?(board)
    if full?(board) == true && won?(board) == false
      return true
    else
      return false
    end
end
  
def over?(board)
    if draw?(board) == true || won?(board) != false
      return true
    else
      return false
    end
end
  
def winner(board)
    if won?(board) != false
      if board[won?(board)[0]] == "X"
        return "X"
      else
        return "O"
      end
    else
      return nil
    end
end

def turn_count(board)
    counter = 0
    board.each do |cell|
        if cell == "X" || cell == "O"
            counter += 1
        else
        end
    end
    return counter
end

def current_player(board)
    if  turn_count(board) % 2 == 0
        return "X"
    else
        return "O"
    end
end