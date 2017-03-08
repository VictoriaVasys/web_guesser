require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@guesses_left = 5

def check_guess(guess)
  @@guesses_left -= 1
  if @@guesses_left == 0
    @@secret_number = rand(100)
    @@guesses_left = 5
    "Sorry, but you've lost! A new secret number has now been generated."
  elsif guess > (@@secret_number + 5)
    @background_color = "red"
    "Way too high!"
  elsif guess > @@secret_number
    @background_color = "#ffcccc"
    "Too high!"
  elsif guess < (@@secret_number - 5)
    @background_color = "red"
    "Way too low!"
  elsif guess < @@secret_number
    @background_color = "#ffcccc"
    "Too low!"
  elsif guess == @@secret_number
    @background_color = "green"
    @@secret_number = rand(100)
    @@guesses_left = 5
    "You got it right! Guess again if you dare. muhahahha"
  end
end

get '/' do
  guess = params["guess"].to_i
  cheat = params["cheat"]
  message = check_guess(guess)
  erb :index, :locals => {:number => @@secret_number, :message => message, :guess => guess, :background_color => @background_color, :cheat => cheat}
end