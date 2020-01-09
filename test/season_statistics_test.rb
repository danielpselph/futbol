require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game_team'
require './lib/season_statistics'

class SeasonStatisticsTest < Minitest::Test
  def setup
    @ss = SeasonStatistics.new
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    @game_teams = GameTeam.from_csv(@game_team_path)
    @game_path = './test/dummy/games_trunc.csv'
    #@game_path = './data/games.csv'
    @games = Game.from_csv(@game_path)
    @season = '20132014'
    @team_path = './test/dummy/teams_trunc.csv'
    @teams = Team.from_csv(@team_path)
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @ss
  end

  def test_it_can_find_games_per_season
    assert_equal ["20122013", "20162017", "20142015", "20152016", "20132014"], SeasonStatistics.all_games_all_seasons.keys
    assert_equal 5, SeasonStatistics.all_games_all_seasons.keys.length
    assert_equal 12, SeasonStatistics.games_per_season(@season).length
    assert_equal 14, SeasonStatistics.game_teams_per_season(@season).length
  end

  def test_it_can_find_coach_by_team_id
    assert_equal ({"16"=>"Joel Quenneville", "19"=>"Ken Hitchcock", "23"=>"John Tortorella"}), SeasonStatistics.coach_by_team_id(@season)
    assert_equal "John Tortorella", SeasonStatistics.winningest_coach(@season)
  end

  def test_it_can_calculate_win_percentage
    assert_equal ["16", "19", "23"], SeasonStatistics.win_percent_by_team_id(@season).keys
    assert_equal 1.0, SeasonStatistics.win_percent_by_team_id(@season)["23"]
    assert_equal "23", SeasonStatistics.winningest_team_by_season(@season)
  end

  def test_it_can_find_worst_team_and_coach
    assert_equal "19", SeasonStatistics.worst_team_by_season(@season)
    assert_equal "Ken Hitchcock", SeasonStatistics.worst_coach(@season)
  end

  def test_it_can_find_postseason_and_regular_percent
    assert_equal 4, SeasonStatistics.post_season_games["20162017"].length
    assert_equal 0, SeasonStatistics.win_percent_post_season("20122013")["3"]
    assert_equal 6, SeasonStatistics.regular_games[@season].length
    assert_equal 1.0, SeasonStatistics.win_percent_regular(@season)["23"]
  end

  def test_it_can_find_biggest_bust_and_surprise
    # assert_nil SeasonStatistics.difference_post_regular_season(@season)["23"]
    #assert_equal "23", SeasonStatistics.biggest_bust_team_id(@season)
    assert_equal "Philadelphia Union", SeasonStatistics.biggest_bust(@season)
    assert_equal "19", SeasonStatistics.biggest_surprise_team_id(@season)
    assert_equal "Philadelphia Union", SeasonStatistics.biggest_surprise(@season)
  end
end
