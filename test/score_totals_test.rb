require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/score_totals'

class ScoreTotalsTest < Minitest::Test
  def setup
    @score_totals = ScoreTotals.new
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

  def test_can_find_highest_score_total
    assert_equal 7, ScoreTotals.highest_total_score
  end

  def test_can_find_lowest_score_total
    assert_equal 1, ScoreTotals.lowest_total_score
  end

  def test_can_find_biggest_blowout
    assert_equal 3, ScoreTotals.biggest_blowout
  end
end
