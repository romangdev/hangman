class Game
  attr_accessor :word_display
  attr_reader :random_word, :incorrect_guesses

  def initialize
    @random_word = ""
    @incorrect_guesses = 6
    @word_display = []
    @incorrect_letters = []
  end

  def get_random_word
    until @random_word.length >= 5 && @random_word.length <= 12
      @random_word = File.readlines("google-10000-english-no-swears.txt").map(&:chomp).sample
    end
  end

  def show_wrong_guesses_left
    puts "You have #{@incorrect_guesses} wrong guess(es) left."
  end

  def fill_empty_word_state
    for i in 0..(self.random_word.length - 1)
      @word_display << "__"
    end
  end

  def display_word_state
    @word_display.each do |char|
      print "#{char} "
    end
    puts "\n"
  end

  def fill_guess(letter_guess)
    if self.random_word.include?(letter_guess)
      puts "Nice guess - #{letter_guess} is in the secret word!"
      self.random_word.split("").each_with_index do |char, idx|
        if char == letter_guess
          self.word_display[idx] = letter_guess
        else
          self.word_display
        end
      end
    else
      false
    end
  end

  def handle_wrong_guess(letter_guess)
    if self.random_word.include?(letter_guess) == false
      @incorrect_guesses -= 1
      @incorrect_letters << letter_guess
      puts "Sorry... that's wrong. #{letter_guess} is NOT in the secret word!"
    end
  end

  def show_guessed_letters
    print "Incorrect guesses: "
    @incorrect_letters.each do |guess|
      print "#{guess}, "
    end
    puts "\n"
  end
end

class Player
  attr_reader :letter_guess
  def initialize
    @letter_guess = ""
  end

  def get_letter_guess 
    puts "Guess a letter:"
    @letter_guess = gets.chomp.downcase
  end
end


game = Game.new
player = Player.new

game.get_random_word
game.fill_empty_word_state

until game.incorrect_guesses == 0
  game.show_wrong_guesses_left

  puts game.random_word

  game.display_word_state

  player.get_letter_guess

  flag = game.fill_guess(player.letter_guess)
  game.handle_wrong_guess(player.letter_guess) if flag == false

  game.show_guessed_letters
  game.display_word_state
end