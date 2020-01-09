require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game_team'
require './lib/game'
require './lib/season_statistics'
require './lib/season_game'
require 'csv'

class SeasonStatisticsTest < Minitest::Test
  def setup
    @game_path = './data/games.csv'
    #@game_path = './test/dummy/games_trunc.csv'
    @games = Game.from_csv(@game_path)
    @game_team_path = './data/game_teams.csv'
    #@game_team_path = './test/dummy/game_teams_trunc.csv'
    @game_teams = GameTeam.from_csv(@game_team_path)
    @sg = SeasonGame.new
    @season = '20132014'
    #@team_path = './test/dummy/teams_trunc.csv'
    #@teams = Team.from_csv(@team_path)
  end

  def test_it_exists
    assert_instance_of SeasonGame, @sg
  end

  def test_season_games_creates_new_value
    SeasonGame.all_season_games
    SeasonGame.all_post_season_games
    SeasonGame.all_regular_season_games
  end
end
