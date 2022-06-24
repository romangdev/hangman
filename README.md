# hangman

A command line based replication of the game Hangman. Tracks incorrect guess limit of 6 instead of displaying hanging man graphic.

![Screen Shot 2022-06-24 at 11 14 40 AM](https://user-images.githubusercontent.com/74276666/175565421-fa0eeada-373b-45d4-990d-7e2169388674.png)

# How It's Made:
Tech used: Ruby

This application was built using pure Ruby. 3 classes were created: a Game class to hold all methods and attributes in which the computer manipulates directly, a Player class to hold all methods and attributes the player manipulates directly, and a Hangman class which contains the majority of code methods organized together to run the actual game. Additionally, the main.rb file contains all code necessary to run the entire games, succintly packed into a few lines. 

Player is allowed to guess letters, save the game, and load in past save files. Computer generates a random word, displays the current word state, tracks incorrect guesses, fills in correct guesses, and more. This game utilizes not only OOP techniques, but is also my first application built employing file manipulation, file organization, and serialization. As mentioned, the player has the option to save their current game state to any file name they choose. Whenever starting up the code, they can then choose to either start a new game, or load in a previously saved file. Whenever a player saves their current game state, the instance of the Game object specifically is serialized and written to a new file stored in the "saves" directory.

# Optimizations
If I had more time with this project, one of the first things I would do would be to implement a feature that allows a player to delete previously saved files from within the game. Currently, there is no ability to do that while they're in the game. So if a player wants to delete a file, they will have to manually search for the saves directory and delete the file they wish to themselves. Another feature I would implement would be for the player to have an option to restart the game whenever a game is finished, rather than the program ending. Additionally, I would write another method that allows the player to exit the game by typing "exit" in game, rather than having to use command line command to leave the game. 

# Lessons Learned:
This project was fantastic practice for file manipulation and serialization. This was a topic that I had some difficulty really grasping. At a "high level" I felt like I had a good understanding of the purpose and benefits of reading and writing to files, and why you would serialize objects. But when it came to the implementation, I really struggled, and didn't understand the topic as well as I thought I did. With some long hours, hard work, and some helpful guidance in the right direction from very smart people, I not only figured out how to properly implement file saving and loading, but I can truly say I understand how it works, and would have no problem teaching the basics to others. 

To add on to that, I learned how to properly organize files by reading through other people's code, which has been great! So instead of having one big mash of code in a main file, classes and modules are now split up and organized. 
