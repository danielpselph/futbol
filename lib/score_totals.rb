require_relative 'game'
require 'csv'

class ScoreTotals

  def self.highest_total_score
    total_goals = Game.all_games.map {|game| game.away_goals + game.home_goals}
    total_goals.max
  end

  def self.lowest_total_score
    total_goals = Game.all_games.map {|game| game.away_goals + game.home_goals}
    total_goals.min
  end

  def self.biggest_blowout
    total_goals_diff = Game.all_games.map do |game|
      (game.away_goals - game.home_goals).abs
    end
    total_goals_diff.max
  end
end
