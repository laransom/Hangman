#!/usr/bin/env ruby
chances = 12
word = ''
guess = ''

File.open("wordbank.txt") do |f|
  word = [*f][rand("wordbank.txt".length)]
end

word = word.chomp
word_inc = "_" * word.length
puts "Welcome to Hangman!"

while chances > 0
  puts
  puts "Word: #{word_inc}"
  puts "Chances remaining: #{chances}"
  print "Guess a single letter (a-z) or the entire word: "
  guess = gets.chomp.downcase
  until /^[a-z]+$/.match(guess)
    print "Please enter a valid letter (a-z) or word: "
    guess = gets.chomp.downcase
  end
  if guess.length > 1
    if guess == word
      puts "Congratulations, you've guessed the word!"
      break
    else
      puts "I'm sorry, that is not the word"
      chances -= 1
    end
  else
    if word.include?(guess)
      counter = 0
      place = 0
      while true
        input = word.index(guess, place)
        if input == nil
          puts counter
          puts word_inc
          break
        else
          word_inc[input] =  guess
          counter += 1
          place = input + 1
        end
      end
      puts
      puts "Found #{counter} occurence(s) of character #{guess}"
      if word_inc == word
        puts "Congratulations, you've guessed the word!"
        break
      end
    else
      puts "Sorry, no #{guess}'s found."
      chances -= 1
    end
  end

end

puts "You're out of chances, better luck next time" unless word_inc == word || guess == word


