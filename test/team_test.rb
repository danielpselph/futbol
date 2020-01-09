require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    @team = Team.new({
      :team_id => "17",
      :franchiseid => "33",
      :teamname => "FutBallers",
      :abbreviation => "DEN",
      :stadium => "Mercedes Benz Superdome"
      })
    @team_path = './test/dummy/teams_trunc.csv'
    @teams = Team.from_csv(@team_path)
    @csv_team = @teams[1]
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_it_has_attributes
    assert_equal "17", @team.team_id
    assert_equal "33", @team.franchise_id
    assert_equal "FutBallers", @team.team_name
    assert_equal "DEN", @team.abbreviation
    assert_equal "Mercedes Benz Superdome", @team.stadium
  end

  def test_it_reads_csv
    assert_instance_of Team, @csv_team
    assert_equal "CHI", @csv_team.abbreviation
    assert_equal "16", @csv_team.franchise_id
    assert_equal "SeatGeek Stadium", @csv_team.stadium
    assert_equal "4", @csv_team.team_id
    assert_equal "Chicago Fire", @csv_team.team_name
  end
end
