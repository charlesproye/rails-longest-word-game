require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @alphabet = ('A'..'Z').to_a
    @arr = @alphabet.sample(10)
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    url_serialized = open(url).read
    @word = JSON.parse(url_serialized)
    @grid = params[:letters].upcase.split("")
    @guess = params[:word]
    existing = @word["found"]
    if existing && grid_test(@grid, @guess)
      @phrase = "Congrats #{@guess} is a valid word"
      @score = @guess.size
    elsif grid_test(@grid, @guess)
      @phrase = "Sorry but #{@guess.upcase} doesn't seem to be an English word..."
      @score = 0
    elsif existing
      @phrase = "Sorry but #{@guess} can't be built out of #{@grid.join(",")}"
      @score = 0
    else
      @phrase = "You are all wrong"
      @score = 0
    end
    session["score"] == nil ? session["score"] = @score : session["score"] += @score
  end

  private

  def grid_test(grid, guess)
    tester = guess.upcase.split("")
    tester.each do |letter|
      index = grid.index(letter)
      return false unless index
      grid.delete_at(index)
    end
  end
end
