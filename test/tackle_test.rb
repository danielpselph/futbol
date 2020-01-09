require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game_team'
require './lib/tackle'
require './lib/game'
require 'mocha/minitest'

class TackleTest < Minitest::Test

  def setup
    Tackle.new
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

  def teardown
    Tackle.clear_all_season_games()
  end

  def test_most_tackles
    game_team_tackles = GameTeam.new({
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
      team_tackles = Team.new({
        :team_id => "3",
        :franchiseid => "33",
        :teamname => "Houston Dynamo",
        :abbreviation => "HOU",
        :stadium => "BBVA Stadium"
        })
      game_tackles = Game.new({
        :game_id => "201203022015",
        :season => "20132014",
        :type => "Preseason",
        :date_time => "12/16/19",
        :away_team_id => "3",
        :home_team_id => "10",
        :away_goals => 4,
        :home_goals => 1,
        :venue => "Mercedes Benz Superdome"
        })

    GameTeam.stub(:all_game_teams, [game_team_tackles]) do
      Team.stub(:all_teams, [team_tackles]) do
        Game.stub(:all_games, [game_tackles]) do
          assert_equal "Houston Dynamo", Tackle.most_tackles("20132014")
        end
      end
    end
  end

  def test_fewest_tackles
    assert_equal "Montreal Impact", Tackle.fewest_tackles("20132014")
  end

  def test_get_most_tackles_hash
    expected = {"16"=>143, "19"=>267, "23"=>14}
      assert_equal expected, Tackle.get_most_tackles_hash("20132014")
  end


end
