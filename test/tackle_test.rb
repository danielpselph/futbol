require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game_team'
require './lib/tackle'
require './lib/game'

class TackleTest < Minitest::Test

  def setup
    Tackle.new
    @team_path = './test/dummy/teams_trunc.csv'
    @game_teams = Team.from_csv(@team_path)
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    @game_teams = GameTeam.from_csv(@game_team_path)
    @game_path = './test/dummy/games_trunc.csv'
    @games = Game.from_csv(@game_path)
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
        :teamname => "K.C. Chiefs",
        :team_id => "3"
        })
      game_tackles = Game.new({
        :season => "123456",
        :game_id => "201203022015"
        })

    GameTeam.stub(:all_game_teams, [game_team_tackles]) do
      Team.stub(:all_teams, [team_tackles]) do
        Game.stub(:all_games, [game_tackles]) do
          assert_equal "K.C. Chiefs", Tackle.most_tackles("123456")
        end
      end
    end

  #   assert_equal "Dallas", Tackle.most_tackles("20132014")
  end

 #  def test_fewest_tackles
 #    assert_equal "Dallas", Tackle.fewest_tackles("20132014")
 #  end
 #
 #  def test_team_seasons
 #    expected = {"20122013"=>
 #  "2012030221201203022220120302232012030224201203022520120303112012030312201203031320120303142012030231201203023220120302332012030234201203023520120302362012030237201203012120120301222012030123201203012420120301252012030151201203015220120301532012030154201203015520120301812012030182201203018320120301842012030185201203018620120301612012030162201203016320120301642012030165201203016620120301672012030111201203011220120301132012030114201203011520120301162012030131201203013220120301332012030134201203013520120301362012030137201203032120120303222012030323201203032420120303252012020225201202057720120201222012020387201202051020120205112012020116",
 # "20162017"=>"2016030171201603017220160301732016030174",
 # "20142015"=>
 #  "2014030411201403041220140304132014030414201403041520140304162014030131201403013220140301332014030134201403013520140303112014030312201403031320140303142014030315",
 # "20152016"=>
 #  "2015030141201503014220150301432015030144201503014520150301812015030182201503018320150301842015030185201503013120150301322015030133201503013420150301352015030136",
 # "20132014"=>
 #  "201303016120130301622013030163201303016420130301652013030166201302067420130201772013021085201302103620130207042013020021"}
 #
 #  assert_equal expected, Tackle.team_seasons
 #  end
 #
 #  def test_get_most_tackles_hash
 #    expected = {"3"=>44}
 #      assert_equal expected, Tackle.get_most_tackles_hash("20132014")
 #  end


end
