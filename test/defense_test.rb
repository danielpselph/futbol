require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/team'
require './lib/game_team'
require './lib/defense'

class DefenseTest < Minitest::Test

  def setup
    Defense.new
    @team_path = './test/dummy/teams_trunc.csv'
    @teams = Team.from_csv(@team_path)
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    @game_teams = GameTeam.from_csv(@game_team_path)
  end

  # def test_it_can_return_best_defense
  #   assert_equal "Portland Timbers", Defense.best_defense
  # end
  #
  # def test_it_can_return_worst_defense
  #   assert_equal "New York City FC", Defense.worst_defense
  # end
  #
  # def test_it_can_get_team_name_from_id
  #   assert_equal "New York City FC", Defense.get_team_name_from_id("9")
  # end
  
  def test_add_goals_to_opposing_team
    game_team_win = GameTeam.new({
      :game_id => "201203022015",
      :team_id => "3",
      :result => "WIN",
      :goals => "4"
      })
      
    game_team_loss = GameTeam.new({
      :game_id => "201203022015",
      :team_id => "3",
      :result => "LOSS",
      :goals => "4"
      })
      
    GameTeam.stub(:all_game_teams, [game_team_win, game_team_loss]) do
      expected = IncrementalAverage.new
      expected.add_sample(4)
      expected.add_sample(4)
      
      assert_equal expected.average, Defense.add_goals_to_opposing_team["3"].average
    end
  end
end
