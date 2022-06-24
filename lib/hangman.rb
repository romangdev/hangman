# Holds the majority of the code needed to run each round of a hangman game
class Hangman
  def self.play_game(game, player)
    until game.incorrect_guesses.zero? || game.winner
      game.show_wrong_guesses_left
      game.show_guessed_letters
      game.display_word_state

      player.get_letter_guess(game.incorrect_letters, game.word_display)
      if player.letter_guess == 'save'
        game.save_game
      else
        flag = game.fill_guess(player.letter_guess)
        game.handle_wrong_guess(player.letter_guess) if flag == false

        game.check_winner
        game.check_loser
      end
    end
  end
end
