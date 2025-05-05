require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { (('A'..'Z').to_a).sample }
    @letters.shuffle!
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].upcase.chars

    if !word_in_grid?(@word, @letters)
      @result = :not_in_grid
    elsif !english_word(@word)
      @result = :not_english
    else
      @result = :success
    end
  end

  def word_in_grid?(word, grid)
    word.chars.all? do |letter|
      word.count(letter) <= grid.count(letter)
    end
  end

  def english_word(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json["found"]
  end
end
