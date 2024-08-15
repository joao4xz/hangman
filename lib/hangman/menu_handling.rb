# frozen_string_literal: true

# Module for the game menu
module MenuHandling
  def start_menu # rubocop:disable Metrics/MethodLength
    puts 'Welcome to Hangman!'

    loop do
      puts "\nType [S] to start, [H] for help or [Q] to quit."
      menu_option = gets.chomp.downcase
      case menu_option
      when  's'
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
