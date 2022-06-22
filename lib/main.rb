class Game
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

  def display_word_state
    for i in 0..(self.random_word.length - 1)
      @word_display << "__"
    end
    
    @word_display.each do |char|
      print "#{char} "
    end
    puts "\n"
  end
end

class Player
  def initialize
    @letter_guess = ""
  end

  def get_letter_guess 
    puts "Guess a letter:"
    @letter_guess = gets.chomp
    puts @letter_guess
  end
end


game = Game.new
player = Player.new

game.get_random_word

game.show_wrong_guesses_left

puts game.random_word

game.display_word_state

player.get_letter_guess