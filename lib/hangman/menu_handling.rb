# frozen_string_literal: true

# Module for the game menu
module MenuHandling
  def start_menu # rubocop:disable Metrics/MethodLength
    puts 'Welcome to Hangman!'

    loop do
      puts "\nType [S] to start, [L] to load a game, [H] for help or [Q] to quit."
      menu_option = gets.chomp.downcase
      case menu_option
      when  's'
        random_word
        game_setup
      when  'l'
        load_game
        game_setup
      when  'h'
        print_help
      when  'q'
        puts 'Exiting...'
        break
      else
        puts 'Invalid option!'
      end
    end
  end
end
