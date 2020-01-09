require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/dummy/games_trunc.csv'
    team_path = './test/dummy/teams_trunc.csv'
    game_teams_path = './test/dummy/game_teams_trunc.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_equal './test/dummy/games_trunc.csv', @stat_tracker.game_path
    assert_equal './test/dummy/teams_trunc.csv', @stat_tracker.team_path
    assert_equal './test/dummy/game_teams_trunc.csv', @stat_tracker.game_team_path
  end
end
