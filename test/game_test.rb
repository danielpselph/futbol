require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new({
      :game_id => "201203022015",
      :season => "20192020",
      :type => "Preseason",
      :date_time => "12/16/19",
      :away_team_id => "3",
      :home_team_id => "10",
      :away_goals => 4,
      :home_goals => 1,
      :venue => "Mercedes Benz Superdome"
      })
    @game_path = './test/dummy/games_trunc.csv'
    @games = Game.from_csv(@game_path)
    @csv_game = @games[4]
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_instance_of Game, @game
    assert_equal "201203022015", @game.game_id
    assert_equal "20192020", @game.season
    assert_equal "Preseason", @game.type
    assert_equal "12/16/19", @game.date_time
    assert_equal "3", @game.away_team_id
    assert_equal "10", @game.home_team_id
    assert_equal 4, @game.away_goals
    assert_equal 1, @game.home_goals
    assert_equal "Mercedes Benz Superdome", @game.venue
  end

  def test_it_reads_csv
    assert_instance_of Game, @csv_game
    assert_equal "2012030225", @csv_game.game_id
    assert_equal "20122013", @csv_game.season
    assert_equal "Postseason", @csv_game.type
    assert_equal "5/25/13", @csv_game.date_time
    assert_equal "3", @csv_game.away_team_id
    assert_equal "6", @csv_game.home_team_id
    assert_equal 1, @csv_game.away_goals
    assert_equal 3, @csv_game.home_goals
    assert_equal "Toyota Stadium", @csv_game.venue
  end
  
  def test_it_gives_count_of_games_by_season
    expected = {"20122013"=>64, "20132014"=>12, "20142015"=>16, "20152016"=>16, "20162017"=>4}
    
    assert_instance_of Hash, Game.count_of_games_by_season
    assert_equal 5, Game.count_of_games_by_season.length
    assert_equal expected, Game.count_of_games_by_season
  end
  
  def test_it_can_return_average_goals_by_season
    expected = {"20122013"=>3.98, "20132014"=>4.17, "20142015"=>3.75, "20152016"=>3.88, "20162017"=>4.75}
    
    assert_instance_of Hash, Game.average_goals_by_season
    assert_equal 5, Game.average_goals_by_season.length
    assert_equal expected, Game.average_goals_by_season
  end
  
  def test_it_can_return_average_goals_per_game
    assert_equal 3.98, Game.average_goals_per_game
  end
end
