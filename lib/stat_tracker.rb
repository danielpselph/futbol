require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'offense'
require_relative 'defense'
require_relative 'season_statistics'
require_relative 'season_game'
require_relative 'wins_and_ties'
require_relative 'fans'
require_relative 'tackle'
require_relative 'score_totals'

require_relative 'accurate'
require_relative 'highest_scores'
require_relative 'lowest_scores'


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
    :worst_fans,
    :winningest_team,
    :highest_total_score,
    :lowest_total_score,
    :biggest_blowout

  def initialize(game_path, team_path, game_team_path)
    Game.from_csv(game_path)
    Team.from_csv(team_path)
    GameTeam.from_csv(game_team_path)

    @count_of_games_by_season = Game.count_of_games_by_season
    @average_goals_by_season = Game.average_goals_by_season
    @average_goals_per_game = Game.average_goals_per_game
    @percentage_home_wins = WinsAndTies.percentage_home_wins
    @percentage_visitor_wins = WinsAndTies.percentage_visitor_wins
    @percentage_ties = WinsAndTies.percentage_ties
    @highest_scoring_visitor = HighestScores.highest_scoring_visitor
    @lowest_scoring_visitor = LowestScores.lowest_scoring_visitor
    @lowest_scoring_home_team = LowestScores.lowest_scoring_home_team
    @highest_scoring_home_team = HighestScores.highest_scoring_home_team
    @count_of_teams = Offense.count_of_teams
    @best_offense = Offense.best_offense
    @worst_offense = Offense.worst_offense
    @best_defense = Defense.best_defense
    @worst_defense = Defense.worst_defense
    @best_fans = Fans.best_fans
    @worst_fans = Fans.worst_fans
    @winningest_team = WinsAndTies.winningest_team
    @highest_total_score = ScoreTotals.highest_total_score
    @lowest_total_score = ScoreTotals.lowest_total_score
    @biggest_blowout = ScoreTotals.biggest_blowout
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

end
