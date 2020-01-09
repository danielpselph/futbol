require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_team'
require './lib/team'
require './lib/game'
require_relative 'test_helper'

class GameTeamTest < Minitest::Test
  def setup
    @game_team = GameTeam.new({
      :game_id => "201203022015",
      :team_id => "3",
      :hoa => "home",
      :result => "WIN",
      :settled_in => "OT",
      :head_coach => "Stephanie",
      :goals => "4",
      :shots => "12",
      :tackles => "7"
      })
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    @game_teams = GameTeam.from_csv(@game_team_path)
    @csv_game_team = @game_teams[1]
    @team_path = './test/dummy/teams_trunc.csv'
    @game_teams = Team.from_csv(@team_path)
    @game_path = './test/dummy/games_trunc.csv'
    @games = Game.from_csv(@game_path)
  end

  def test_it_exists
    assert_instance_of GameTeam, @csv_game_team
  end

  def test_it_has_attributes
    assert_instance_of GameTeam, @game_team
    assert_equal "201203022015", @game_team.game_id
    assert_equal "3", @game_team.team_id
    assert_equal "home", @game_team.hoa
    assert_equal "WIN", @game_team.result
    assert_equal "OT", @game_team.settled_in
    assert_equal "Stephanie", @game_team.head_coach
    assert_equal "4", @game_team.goals
    assert_equal "12", @game_team.shots
    assert_equal "7", @game_team.tackles
  end

  def test_it_reads_csv
    assert_instance_of GameTeam, @csv_game_team
    assert_equal "2012030221", @csv_game_team.game_id
    assert_equal "6", @csv_game_team.team_id
    assert_equal "home", @csv_game_team.hoa
    assert_equal "WIN", @csv_game_team.result
    assert_equal "OT", @csv_game_team.settled_in
    assert_equal "Claude Julien", @csv_game_team.head_coach
    assert_equal "3", @csv_game_team.goals
    assert_equal "12", @csv_game_team.shots
    assert_equal "51", @csv_game_team.tackles
  end

  def test_percentage_home_wins
    assert_equal 0.50, GameTeam.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.50, GameTeam.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.20, GameTeam.percentage_ties
  end

  def test_highest_scoring_visitor
    #assert_equal "26", GameTeam.highest_scoring_visitor
    assert_equal "FC Cincinnati", GameTeam.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal "Houston Dynamo", GameTeam.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Houston Dynamo", GameTeam.lowest_scoring_home_team
  end

  def test_highest_scoring_home_team
    assert_equal "FC Dallas", GameTeam.highest_scoring_home_team
  end

  def test_best_fans
    assert_equal "AAAAAA", GameTeam.best_fans
  end

  def test_worst_fans
    assert_instance_of String, GameTeam.worst_fans
  end
end
