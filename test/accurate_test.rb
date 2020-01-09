require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game_team'
require './lib/tackle'
require './lib/game'
require './lib/accurate'

class AccurateTest < Minitest::Test

  def setup
    Accurate.new
    @team_path = './test/dummy/teams_trunc.csv'
    # @team_path = './data/teams.csv'
    @game_teams = Team.from_csv(@team_path)
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    # @game_team_path = './data/game_teams.csv'
    @game_teams = GameTeam.from_csv(@game_team_path)
    @game_path = './test/dummy/games_trunc.csv'
    # @game_path = './data/games.csv'
    @games = Game.from_csv(@game_path)
  end

  def test_most_accurate_team
    assert_equal "New York City FC", Accurate.most_accurate_team("20122013")
  end

  def test_least_accurate_team
    assert_equal "Houston Dynamo", Accurate.least_accurate_team("20122013")
  end

  def test_it_can_create_goals_and_shots_hash
    expected = {"3"=>[74, 14], "6"=>[76, 24], "5"=>[71, 17], "17"=>[98, 27],
      "16"=>[99, 23], "9"=>[36, 14], "8"=>[43, 9], "30"=>[33, 7], "26"=>[36, 10],
      "19"=>[42, 10], "24"=>[54, 17], "2"=>[47, 11], "15"=>[38, 12]}

    assert_equal expected, Accurate.goals_and_shots("20122013")
  end

  def test_it_can_create_a_hash_ratio
    expected = {"3"=>5.285714285714286, "6"=>3.1666666666666665, "5"=>4.176470588235294,
      "17"=>3.6296296296296298, "16"=>4.304347826086956, "9"=>2.5714285714285716,
      "8"=>4.777777777777778, "30"=>4.714285714285714, "26"=>3.6, "19"=>4.2,
      "24"=>3.176470588235294, "2"=>4.2727272727272725, "15"=>3.1666666666666665}

    assert_equal expected, Accurate.ratio_hash("20122013")
  end
end
