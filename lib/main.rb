class Game
  attr_accessor :word_display
  attr_reader :random_word

  def initialize
    @random_word = ""
    @incorrect_guesses = 6
    @word_display = []
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
end

class Player
  attr_reader :letter_guess
  def initialize
    @letter_guess = ""
  end

  def get_letter_guess 
    puts "Guess a letter:"
    @letter_guess = gets.chomp.downcase
    puts @letter_guess
  end
end


game = Game.new
player = Player.new

game.get_random_word

game.show_wrong_guesses_left

puts game.random_word

game.fill_empty_word_state
game.display_word_state

player.get_letter_guess

game.fill_guess(player.letter_guess)

game.display_word_state