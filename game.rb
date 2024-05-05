require_relative 'player'
require_relative 'question'

class Game
  def initialize
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
    @current_player = @player1
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def play
    while @player1.alive? && @player2.alive?
      question = Question.new
      puts "#{@current_player.name}: #{question.ask}"
      print "> "
      player_answer = gets.chomp.to_i

      if player_answer == question.answer
        puts "YES! You are correct."
      else
        puts "Seriously? No!"
        @current_player.lose_life
      end

      display_scores
      switch_player
    end
    game_over
  end

  def display_scores
    puts "----- NEW TURN -----"
    puts "P1: #{@player1.lives}/3 vs P2: #{@player2.lives}/3"
  end

  def game_over
    winner = @player1.alive? ? @player1 : @player2
    puts "----- GAME OVER -----"
    puts "#{winner.name} wins with a score of #{winner.lives}/3"
    puts "Good bye!"
  end
end
