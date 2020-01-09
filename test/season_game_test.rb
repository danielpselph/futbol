require 'minitest/autorun'
require 'minitest/pride'
require './lib/season_game'
require './lib/game'
require './lib/game_team'

class SeasonGameTest < Minitest::Test

  def test_it_exists
    season = SeasonGame.new

    assert_equal season.all_season_games
  end
end
