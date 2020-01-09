require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'offense'
require_relative 'defense'
require_relative 'tackle'
require_relative 'score_totals'
require_relative 'accurate'

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
    @best_defense = Defense.best_defense
    @worst_defense = Defense.worst_defense
    @best_fans = GameTeam.best_fans
    @worst_fans = GameTeam.worst_fans
  end

  def most_tackles(season)
    Tackle.most_tackles(season)
  end

  def fewest_tackles(season)
    Tackle.fewest_tackles(season)
  end

  def most_accurate_team(season)
    Accurate.most_accurate_team(season)
  end

  def least_accurate_team(season)
    Accurate.least_accurate_team(season)
  end

  # def highest_score_total
  #   ScoreTotals.highest_score_total
  # end
  #
  # def lowest_score_total
  #   ScoreTotals.lowest_score_total
  # end
  #
  # def biggest_blowout
  #   ScoreTotals.biggest_blowout
  # end
end
