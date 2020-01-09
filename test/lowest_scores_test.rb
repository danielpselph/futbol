require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/lowest_scores'

class LowestScoresTest < Minitest::Test
  def setup
    @team_path = './test/dummy/teams_trunc.csv'
    Team.from_csv(@team_path)
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    GameTeam.from_csv(@game_team_path)
  end
  
  def test_lowest_scoring_visitor
    assert_equal "Seattle Sounders FC", LowestScores.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Chicago Fire", LowestScores.lowest_scoring_home_team
  end
end