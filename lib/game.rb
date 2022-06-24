require 'yaml'

# Game holds all methods and attributes in which the computer, not the player, manipulates.
# This includes tracking incorrect guesses left, past guessed letter, displaying the current 
# state of the word guess, and more.
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

  # Shows the current state of the word to a player with unguessed letters and correctly guessed letters
  def display_word_state
    @word_display.each do |char|
      print "#{char} "
    end
    puts "\n"
  end

  # Fills empty letter slots with player letter guess if the guess is correct
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
    if @incorrect_guesses.zero?
      puts "\nWhomp whomp... you've lost."
      puts "The word was: #{@random_word}"
    end
  end

  def save_game
    @save_yaml = to_yaml
    Dir.mkdir('saves') unless Dir.exist?('saves')
    puts "\nWhat do you want to name your save file?"
    @save_name = gets.chomp
    File.open("saves/#{@save_name}", 'w') { |file| file.write @save_yaml }
    puts "\nYOUR GAME HAS BEEN SAVED.\n"
  end

  def self.from_yaml(string)
    data = YAML.load File.read(string)
    new(data[:random_word], data[:incorrect_guesses], data[:word_display],
        data[:incorrect_letters], data[:winner])
  end

  protected

  def to_yaml
    YAML.dump({
                random_word: @random_word,
                incorrect_guesses: @incorrect_guesses,
                word_display: @word_display,
                incorrect_letters: @incorrect_letters,
                winner: @winner
              })
  end
end
