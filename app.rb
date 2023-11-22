class Player
  attr_accessor :chosen_colors, :turns

  def initialize
    @chosen_colors = []
    @turns = 0
  end

  def make_guess
    puts "Guess one at a a time. Start with 1, then 2, etc."
    @chosen_colors << gets.chomp
    @chosen_colors[1] = gets.chomp
    @chosen_colors[2] = gets.chomp
    @chosen_colors[3] = gets.chomp
    puts "You guessed: #{@chosen_colors}"
    @turns += 1
    @chosen_colors
  end
end

class Game
  attr_accessor :correct_sequence, :turns, :game_active

  def initialize(player)
    @player = player
    @correct_sequence = pick_sequence
    @game_active = true
    p @correct_sequence
    start_message
    start_game
  end

  def start_message
    puts "Welcome to MasterMind."
    puts 'Choose four colors. The options are red, orange, yellow, green, blue, and purple.'
  end

  def pick_sequence
    color_options = ['red', 'orange', 'yellow', 'green', 'blue', 'purple']
    color_options[0..3].shuffle
  end

  def start_game
    while @game_active
      @player.make_guess
      check_game_state
    end
  end

  def check_game_state
    if @player.turns == 12 && game_active
      puts "Out of turns. The answer was: #{correct_sequence}."
      @game_active = false
    elsif @player.chosen_colors == @correct_sequence
      puts 'Winner!'
      @game_active = false
    end
  end
end

player = Player.new
Game.new(player)
