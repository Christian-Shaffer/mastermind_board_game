class Player
  attr_accessor :chosen_colors, :turns

  def initialize
    @chosen_colors = []
    @turns = 0
  end

  def make_guess
    @chosen_colors = []
    puts 'Guess one at a a time. Start with 1, then 2, etc.'
    while @chosen_colors.length < 4
      guess = gets.chomp
      if valid_guess?(guess)
        @chosen_colors << guess
      else
        puts 'Invalid. Needs to be one of the six valid colors without spelling mistakes or repeats for each turn.'
      end
    end
    puts "You guessed: #{@chosen_colors}"
    @turns += 1
    @chosen_colors
  end

  def valid_guess?(guess)
    if !@chosen_colors.include?(guess) && Game.color_options.include?(guess)
      true
    else
      false
    end
  end
end

class Game
  attr_accessor :correct_sequence, :turns, :game_active

  @@color_options = %w[red orange yellow green blue purple]

  def initialize(player) # maybe can put chosen sequence in here from player
    @player = player
    @correct_sequence = pick_sequence
    @game_active = true
    p "For debugging only: #{@correct_sequence}"
    start_message
    start_game
  end

  def start_message
    puts 'Welcome to MasterMind.'
    puts 'Choose four colors. The options are red, orange, yellow, green, blue, and purple.'
  end

  def self.color_options
    @@color_options
  end

  def pick_sequence
    @@color_options[0..3].shuffle
  end

  def start_game
    while @game_active
      @player.make_guess
      give_feedback
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

  def give_feedback
    correct = 0
    right_color = 0
    @player.chosen_colors.each_index do |index|
      if @player.chosen_colors[index] == correct_sequence[index]
        correct += 1
      elsif correct_sequence.include?(@player.chosen_colors[index]) && @player.chosen_colors[index] != correct_sequence[index]
        right_color += 1
      end
    end
    puts "Correct: #{correct}"
    puts "Right color: #{right_color}"
  end
end

player = Player.new
Game.new(player)
