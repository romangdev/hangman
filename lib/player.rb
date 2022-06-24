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