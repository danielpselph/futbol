require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/highest_scores'

class HighestScoresTest < Minitest::Test
  def setup
    @team_path = './test/dummy/teams_trunc.csv'
    Team.from_csv(@team_path)
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    GameTeam.from_csv(@game_team_path)
  end
  
  def test_highest_scoring_visitor
    #assert_equal "26", GameTeam.highest_scoring_visitor
    assert_equal "FC Dallas", HighestScores.highest_scoring_visitor
  end
  
  def test_highest_scoring_home_team
    assert_equal "New York City FC", HighestScores.highest_scoring_home_team
  end
end