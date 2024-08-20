# frozen_string_literal: true

require 'json'

require_relative 'hangman/menu_handling'

# Game hangman class
class Hangman # rubocop: disable Metrics/ClassLength
  include MenuHandling

  def initialize
    @word = ''
    @masked_word = ''
    @guessed = { letters: [], missed: 0 }
    # 'not_over' 'won' 'lost'
    @game_status = 'not_over'
  end

  def game_setup # rubocop: disable Metrics/MethodLength
    puts "\n[TIP] Type \"Load\" to load a game and \"Save\" to save it."
    while @game_status == 'not_over'
      puts "\nGuess a letter:"
      guessed_letter = gets.chomp.downcase
      save_game and break if guessed_letter == 'save'

      load_game and next if guessed_letter == 'load'
      next unless letter_valid? guessed_letter

      @guessed[:letters].push guessed_letter
      letter_correct? guessed_letter
      print_round
      @game_status = check_game_status
    end
    reset_game
  end

  def random_word # rubocop:disable Metrics/MethodLength
    File.open('google-10000-english.txt', 'r') do |f|
      loop do
        rand_number = rand(0..9894)
        f.each_line do |line|
          @word = line if f.lineno == rand_number
        end
        break if @word.length >= 6 && @word.length <= 13

        f.rewind
      end
    end
    @masked_word = '_' * (@word.length - 1)
    # puts "\n#{@word}"
    # puts "\n#{@masked_word}"
  end

  def letter_valid?(guessed_letter)
    if guessed_letter.length != 1 || guessed_letter.ord < 97 || guessed_letter.ord > 122
      puts "\nInvalid character!"
    elsif @guessed[:letters].include? guessed_letter
      puts "\nRepeated letter!"
    else
      return true
    end
    false
  end

  def letter_correct?(guessed_letter)
    if @word.include? guessed_letter
      puts 'Correct!'
      (0...@word.length).find_all { |i| @masked_word[i] = guessed_letter if @word[i, 1] == guessed_letter }
    else
      puts 'Incorrect!'
      @guessed[:missed] = @guessed[:missed] + 1
    end
  end

  def check_game_status
    if @masked_word.split('').none? { |letter| letter == '_' }
      puts "\nYou won!"
      return 'won'
    elsif @guessed[:missed] >= 7
      puts "\nYou lost! The word was \"#{@word.tr("\n", '')}\"."
      return 'lost'
    end
    'not_over'
  end

  def save_game
    puts "\nWrite the save file name:"
    file_name = gets.chomp.downcase
    puts "\nSaving file to \"#{file_name}\"..."
    Dir.mkdir('saves') unless File.exist?('saves')
    File.open("saves/#{file_name}", 'w') do |f|
      json_hash = { word: @word, masked_word: @masked_word, guessed: @guessed, game_status: @game_status }
      f.write(JSON.pretty_generate(json_hash))
    end
    true
  end

  def load_game # rubocop:disable Metrics/MethodLength
    puts "\nWrite the file to load:"
    file_name = gets.chomp.downcase
    if File.exist?("saves/#{file_name}")
      file = File.read("saves/#{file_name}")
      parsed_data = JSON.parse(file, { symbolize_names: true })
      @word, @masked_word, @guessed, @game_status = parsed_data.values_at(:word, :masked_word, :guessed, :game_status)
      puts 'File loaded!'
      print_round
    else
      puts 'Invalid filename!'
    end
    true
  end

  def reset_game
    @word = ''
    @masked_word = ''
    @guessed = { letters: [], missed: 0 }
    @game_status = 'not_over'
  end

  def print_hangman(guesses) # rubocop:disable Metrics/CyclomaticComplexity
    puts "\n     ____\n    |    |"
    puts "    |   #{' O' if guesses.positive?}"
    puts "    |   #{'/' if guesses > 1}#{'|' if guesses > 2}#{'\\' if guesses > 3}"
    puts "    |   #{' |' if guesses > 4}"
    puts "    |   #{'/' if guesses > 5}#{' \\' if guesses > 6}"
    puts '   _|_'
  end

  def print_round
    print_hangman @guessed[:missed]
    puts "\nWord: #{@masked_word}"
    puts "Guessed letters: #{@guessed[:letters].join(', ')}"
  end

  def print_help
    puts "\nHow to Play Hangman:\n\n"
    puts 'Hangman is a word-guessing game. The objective is to guess the hidden word one letter at a time.'
    puts 'The word will have a length between 5-12 letters.'
    puts 'You have 7 incorrect guesses before the game is over.'
    puts 'For each incorrect guess, a part of the hangman is drawn.'
    puts 'Once the entire hangman is drawn, you lose the game.'
    puts 'If you guess all the letters in the word before running out of guesses, you win!'
  end
end
