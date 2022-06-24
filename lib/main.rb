require "yaml"
require_relative "hangman"
require_relative "game"
require_relative "player"

player = Player.new
game_state = player.choose_game_state

case game_state
when "new"
  game = Game.new

  game.get_random_word
  game.fill_empty_word_state

  Hangman.play_game(game, player)

when "load"
  player.get_file_load_name
  game = Game.from_yaml("saves/#{player.file_name}")

  Hangman.play_game(game, player)
end
