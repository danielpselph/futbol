require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'offense'
require_relative 'defense'
require_relative 'season_statistics'
require_relative 'season_game'

class StatTracker

  def self.from_csv(file_path)
    game_path = file_path[:games]
    team_path = file_path[:teams]
    game_team_path = file_path[:game_teams]

    StatTracker.new(game_path, team_path, game_team_path)
  end

  attr_reader :count_of_games_by_season,
    :average_goals_by_season,
    :average_goals_per_game,
    :percentage_home_wins,
    :percentage_visitor_wins,
    :percentage_ties,
    :highest_scoring_visitor,
    :lowest_scoring_visitor,
    :lowest_scoring_home_team,
    :highest_scoring_home_team,
    :count_of_teams,
    :best_offense,
    :worst_offense,
    :best_defense,
    :worst_defense,
    :best_fans,
    :worst_fans

  def initialize(game_path, team_path, game_team_path)
    Game.from_csv(game_path)
    Team.from_csv(team_path)
    GameTeam.from_csv(game_team_path)

    @count_of_games_by_season = Game.count_of_games_by_season
    @average_goals_by_season = Game.average_goals_by_season
    @average_goals_per_game = Game.average_goals_per_game
    @percentage_home_wins = GameTeam.percentage_home_wins
    @percentage_visitor_wins = GameTeam.percentage_visitor_wins
    @percentage_ties = GameTeam.percentage_ties
    @highest_scoring_visitor = GameTeam.highest_scoring_visitor
    @lowest_scoring_visitor = GameTeam.lowest_scoring_visitor
    @lowest_scoring_home_team = GameTeam.lowest_scoring_home_team
    @highest_scoring_home_team = GameTeam.highest_scoring_home_team
    @count_of_teams = Offense.count_of_teams
    @best_offense = Offense.best_offense
    @worst_offense = Offense.worst_offense
    # best_defense = Defense.best_defense
    # worst_defense = Defense.worst_defense
    @best_fans = GameTeam.best_fans
    @worst_fans = GameTeam.worst_fans
  end

  def winningest_coach(season)
    SeasonStatistics.winningest_coach(season)
  end

  def worst_coach(season)
    SeasonStatistics.worst_coach(season)
  end

  def biggest_bust(season)
    SeasonStatistics.biggest_bust(season)
  end

  def biggest_surprise(season)
    SeasonStatistics.biggest_surprise(season)
  end
end
