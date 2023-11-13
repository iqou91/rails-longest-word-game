require 'open-uri'
require 'json'
class GamesController < ApplicationController
  VOWELS = %w(A E I O U)
  def new
    @letters = Array.new(10) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end
  def score
    @word = params[:word]
    letters = params[:letters]
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    result = JSON.parse(response)
    if result['found'] && @word.chars.all? { |letter| letters.include?(letter) }
      @score = "Congratulations! #{@word} is a valid word and can be formed from the given letters."
    elsif result['found']
      @score = "The word is valid, but it can't be formed from the given letters."
    else
      @score = "Sorry, #{@word} is not a valid English word. mes letters #{letters}"
    end
  end
end
