require "yaml"

class Game
  attr_accessor :word_display, :incorrect_letters
  attr_reader :random_word, :incorrect_guesses, :winner

  def initialize(random_word = '', incorrect_guesses = 6, word_display = [], incorrect_letters = [], winner = false)
    @random_word = random_word
    @incorrect_guesses = incorrect_guesses
    @word_display = word_display
    @incorrect_letters = incorrect_letters
    @winner = winner
  end

  def get_random_word
    until @random_word.length >= 5 && @random_word.length <= 12
      @random_word = File.readlines('google-10000-english-no-swears.txt').map(&:chomp).sample
    end
  end

  def show_wrong_guesses_left
    puts "\nYou have #{@incorrect_guesses} wrong guess(es) left."
  end

  def fill_empty_word_state
    for i in 0..(random_word.length - 1)
      @word_display << '__'
    end
  end

  def display_word_state
    @word_display.each do |char|
      print "#{char} "
    end
    puts "\n"
  end

  def fill_guess(letter_guess)
    if random_word.include?(letter_guess)
      puts "\nNice guess - #{letter_guess} is in the secret word!"
      random_word.split('').each_with_index do |char, idx|
        if char == letter_guess
          word_display[idx] = letter_guess
        else
          word_display
        end
      end
    else
      false
    end
  end

  def handle_wrong_guess(letter_guess)
    if random_word.include?(letter_guess) == false
      @incorrect_guesses -= 1
      @incorrect_letters << letter_guess
      puts "\nSorry... that's wrong. #{letter_guess} is NOT in the secret word!"
    end
  end

  def show_guessed_letters
    print 'Incorrect guesses made: '
    @incorrect_letters.each do |guess|
      print "#{guess}, "
    end
    puts "\n"
  end

  def check_winner
    if @word_display.join == @random_word
      @winner = true
      puts "\nCongratulations, you've won!"
      puts "The word was: #{@random_word}"
    end
  end

  def check_loser
    if @incorrect_guesses == 0
      puts "\nWhomp whomp... you've lost."
      puts "The word was: #{@random_word}"
    end
  end

  def save_game
    @save_yaml = self.to_yaml
    Dir.mkdir("saves") unless Dir.exist?("saves")
    puts "\nWhat do you want to name your save file?"
    @save_name = gets.chomp
    File.open("saves/#{@save_name}", "w") {|file| file.write @save_yaml}
    puts "\nYOUR GAME HAS BEEN SAVED.\n"
  end

  def self.from_yaml(string)
    data = YAML.load File.read(string)
    self.new(data[:random_word], data[:incorrect_guesses], data[:word_display], 
      data[:incorrect_letters], data[:winner])
  end

  protected

  def to_yaml
    YAML.dump ({
      random_word: @random_word,
      incorrect_guesses: @incorrect_guesses,
      word_display: @word_display,
      incorrect_letters: @incorrect_letters,
      winner: @winner
    })
  end
end

class Player
  attr_reader :letter_guess, :file_name

  def initialize
    @letter_guess = ''
  end

  def get_letter_guess(incorrect_letters, word_display)
    begin
      guess_flag = false
      puts "Guess a letter (or type 'save' to save the game):"
      @letter_guess = gets.chomp.downcase
      if @letter_guess == "save"
        @letter_guess
      else
        if incorrect_letters.include?(@letter_guess) || word_display.include?(@letter_guess)
          guess_flag = true
          raise "ERROR: Previously made guess"
        elsif @letter_guess.length > 1 || @letter_guess.count("a-z") == 0
          raise "ERROR: Incorrect input"
        else
          @letter_guess
        end
      end
    rescue
      if guess_flag == true
        puts "\nYou've already guessed #{letter_guess}. Please try again."
      else
        puts "\nMake sure you enter a letter, and only one letter."
      end
      retry
    else
      @letter_guess
    end
  end

  def choose_game_state
    begin
      puts "\nType 'load' if you want to play your last saved game."
      puts "Type 'new' if you want to play a new game."
      @game_state = gets.chomp
      raise "ERROR: Incorrect input" if @game_state != "new" && @game_state != "load"
    rescue
      puts "\nYou must've mistyped. Please try again."
      retry
    else
      @game_state
    end
  end

  def get_file_load_name 
    begin
      puts "\nWhich save file do you want to load?"
      Dir.entries("saves").each do |file_name|
        print "#{file_name}  " unless file_name == "." || file_name == ".."
      end
      puts "\n"
      puts "\nFile name: "
      @file_name = gets.chomp
      unless Dir.entries("saves").include?(@file_name)
        raise "ERROR: File name does not exist!"
      end
    rescue
      puts "\nThat file name does not exist... please try again!"
      sleep 1
      retry
    else
      print "\n."
      sleep 0.5
      print "."
      sleep 0.5
      print "."
      sleep 0.5
      print " Loaded Successfully!\n"
    end
  end
end

player = Player.new

game_state = player.choose_game_state

if game_state == "new"
  game = Game.new

  game.get_random_word
  game.fill_empty_word_state

  until game.incorrect_guesses.zero? || game.winner
    game.show_wrong_guesses_left
    game.show_guessed_letters

    puts game.random_word

    game.display_word_state

    player.get_letter_guess(game.incorrect_letters, game.word_display)

    if player.letter_guess == "save"
      game.save_game
    else
      flag = game.fill_guess(player.letter_guess)
      game.handle_wrong_guess(player.letter_guess) if flag == false
    
      game.check_winner
      game.check_loser
    end
  end

elsif game_state == "load"
  player.get_file_load_name
  game = Game.from_yaml("saves/#{player.file_name}")

  until game.incorrect_guesses.zero? || game.winner
    game.show_wrong_guesses_left
    game.show_guessed_letters

    puts game.random_word
    game.display_word_state

    player.get_letter_guess(game.incorrect_letters, game.word_display)
    if player.letter_guess == "save"
      game.save_game
    else
      flag = game.fill_guess(player.letter_guess)
      game.handle_wrong_guess(player.letter_guess) if flag == false
    
      game.check_winner
      game.check_loser
    end
  end
end