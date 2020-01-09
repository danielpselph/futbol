require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/fans'

class FansTest < Minitest::Test
  def setup
    @team_path = './test/dummy/teams_trunc.csv'
    Team.from_csv(@team_path)
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    GameTeam.from_csv(@game_team_path)
  end
  
  def test_best_fans
    assert_equal "Montreal Impact", Fans.best_fans
  end
  
  def test_worst_fans
    assert_equal [], Fans.worst_fans
  end
end