class Game
  attr_accessor :correct_sequence, :turns, :game_active

  @@color_options = %w[red orange yellow green blue purple]

  def initialize
    @correct_sequence = Game.pick_sequence
    @game_active = true
    p "For debugging only: #{@correct_sequence}"
    start_message
    start_game
  end

  def self.color_options
    @@color_options
  end

  def start_message
    puts 'Welcome to MasterMind.'
    puts "Do you want to be the guesser or creator?. Type 'g' or 'c'."
    answer = gets.chomp
    if answer.downcase == 'g'
      puts 'Okay, you are the guesser'
      create_player
    elsif answer.downcase == 'c'
      puts 'Alright, you are the creator.'
      create_computer
    end
    puts 'Choose four colors. The options are red, orange, yellow, green, blue, and purple.'
  end

  def create_player
    @guesser = Player.new
  end

  def create_computer
    @guesser = Computer.new
  end

  def self.pick_sequence
    shuffled = @@color_options.shuffle
    shuffled[0..3]
  end

  def start_game
    while @game_active
      @guesser.make_guess
      give_feedback
      check_game_state
    end
  end

  def check_game_state
    if @guesser.chosen_colors == @correct_sequence
      puts 'Winner!'
      @game_active = false
    elsif @guesser.turns == 12 && game_active
      puts "Out of turns. The answer was: #{@correct_sequence}."
      @game_active = false
    end
  end

  def give_feedback
    correct = 0
    right_color = 0
    @guesser.chosen_colors.each_index do |index|
      if @guesser.chosen_colors[index] == correct_sequence[index]
        correct += 1
      elsif correct_sequence.include?(@guesser.chosen_colors[index]) && @guesser.chosen_colors[index] != correct_sequence[index]
        right_color += 1
      end
    end
    puts "Correct: #{correct}"
    puts "Right color: #{right_color}"
  end
end

class Guesser
  attr_accessor :chosen_colors, :turns

  def initialize
    @chosen_colors = []
    @turns = 0
  end

  def valid_guess?(guess)
    if !@chosen_colors.include?(guess) && Game.color_options.include?(guess)
      true
    else
      false
    end
  end
end

class Player < Guesser
  def initialize
    super
    puts 'hehe'
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
  end
end

class Computer < Guesser
  def initialize
    super
    puts 'beepboop'
  end

  def make_guess
    #sleep 1
    puts 'Okay, computer.. Guess one at a a time. Start with 1, then 2, etc.'
    @chosen_colors = Game.pick_sequence
    puts "Computer: I guess #{@chosen_colors}."
    @turns += 1
    puts @turns
  end
end

Game.new
