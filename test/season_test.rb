require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/season'
require './lib/game'
require './lib/game_team'

class SeasonTest < Minitest::Test

  def test_it_exists
    season = Season.new

    assert_equal nil, season.season_games
  end
end
