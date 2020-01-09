require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game_team'
require './lib/offense'

class OffenseTest < Minitest::Test

  def setup
    @offense = Offense.new
    @team_path = './test/dummy/teams_trunc.csv'
    @game_teams = Team.from_csv(@team_path)
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    @game_teams = GameTeam.from_csv(@game_team_path)
  end

  def test_it_exists
    assert_instance_of Offense, @offense
  end

  def test_it_can_count_teams
    assert_equal 32, Offense.count_of_teams
  end

  def test_it_can_add_goals_to_team
    hash = {}
    team_id = 123

    Offense.add_goals_to_team(team_id, 3, hash)

    assert_equal 3, hash[123].average

    Offense.add_goals_to_team(team_id, 1, hash)

    assert_equal 2, hash[123].average

    Offense.add_goals_to_team(234, 4, hash)

    assert_equal 2, hash.length
    assert_equal 4, hash[234].average
    assert_equal 2, hash[123].average
  end
  def test_best_offense
    assert_equal "New York City FC", Offense.best_offense
  end

  def test_it_can_get_team_name_from_id
    assert_equal "New York City FC", Offense.get_team_name_from_id("9")
  end

  def test_it_can_get_team_goal_avg_hash
    assert_instance_of Hash, Offense.get_team_goal_avg_hash
  end

  def test_it_can_return_worst_offense
    assert_equal "Chicago Fire", Offense.worst_offense
  end
end
