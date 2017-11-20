require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @grid = params[:letters]
    @guess = params[:guess].upcase
    if guess_in_grid
      url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
      result = JSON.parse(open(url).read)
      if result["found"]
        @message = "Congrats. <strong>#{@guess}</strong> is a valid word."
      else
        @message = "Sorry but <strong>#{@guess}</strong> does not seem to be a valid English word."
      end
    else
      @message = "Sorry. <strong>#{@guess}</strong> can not be built out of #{@grid.split('').join(", ")}."
    end
  end

  private

  def guess_in_grid
    @guess.split.all? do |l|
      @grid.count(l) >= 1 && @guess.count(l) <= @grid.count(l)
    end
  end
end

