# Hangman

## Description
This project is part of The Odin Project curriculum. It implements the game Hangman where players attempt to guess a hidden word one letter at a time. The game includes features like saving/loading games and provides visual feedback through ASCII text.

## Game Rules
- A random word (5-12 letters) is selected from a dictionary
- Players have 7 attempts to guess the word correctly
- Each incorrect guess adds a part to the hangman drawing
- The game ends when either:
  - The player guesses the word correctly (Win)
  - The hangman drawing is completed (Loss)

## Features
- Save game progress
- Load previous games
- Visual hangman ASCII art
- Word dictionary with over 9,800 words
- Case-insensitive input

## Usage
```ruby
# Game Commands
S - Start new game
L - Load saved game
H - Help menu
Q - Quit game
# During gameplay
- Enter a single letter to make a guess
- Type "Save" to save current game
- Type "Load" to load a previous game
```

## Prerequisites
- Ruby installed on your system
- Bundler gem installed (`gem install bundler`)

## Required Gems
- json (~> 2.7)
- rubocop (~> 1.65)

## Installation
1. Clone this repository
    ```bash
    git clone https://github.com/joao4xz/hangman.git
    ```
2. Navigate to the project directory
    ```bash
    cd hangman
    ```
3. Install dependencies
    ```bash
    bundle install
    ```
4. Run the game:
    ```bash
    bundle exec ruby main.rb
    ```