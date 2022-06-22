class Game
  attr_reader :random_word

  def initialize
    @random_word = ""
    @incorrect_guess = 6
  end

  def get_random_word
    until @random_word.length >= 5 && @random_word.length <= 12
      @random_word = File.readlines("google-10000-english-no-swears.txt").map(&:chomp).sample
    end
  end
end


game = Game.new
secret_word = game.get_random_word


