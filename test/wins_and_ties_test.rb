require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/wins_and_ties'

class WinsAndTiesTest < Minitest::Test
  def setup
    @team_path = './test/dummy/teams_trunc.csv'
    Team.from_csv(@team_path)
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    GameTeam.from_csv(@game_team_path)
  end
  
  def test_percentage_home_wins
    assert_equal 0.62, WinsAndTies.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.36, WinsAndTies.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.02, WinsAndTies.percentage_ties
  end
  
  def test_winningest_team
    assert_equal "FC Dallas", WinsAndTies.winningest_team
  end
end