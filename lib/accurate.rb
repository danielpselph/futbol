require 'csv'
require_relative 'game_team'
require_relative 'team'
require_relative 'game'
require_relative 'data_objects/incremental_average'
require_relative 'season_game'
require_relative 'modules/team_name'

class Accurate < SeasonGame
  extend TeamName

  def self.most_accurate_team(season)
    hash = ratio_hash(season)
    min = hash.min_by {|key, value| value}

    get_team_name_from_id(min[0])
  end

  def self.least_accurate_team(season)
      hash = ratio_hash(season)
      max = hash.max_by {|key, value| value}

      get_team_name_from_id(max[0])
  end

  def self.goals_and_shots(season)
    new_hash = {}

    value_hash = all_season_games[season]

    ratio = value_hash.map do |key, value|
      value.map do |game|
        shot = game.shots.to_i
        goal = game.goals.to_i
        total = [shot, goal]
        if new_hash.key?(game.team_id)
          new_hash[game.team_id] = new_hash[game.team_id].zip(total).map{|x, y| x + y}
        else
          new_hash[game.team_id] = total
        end
      end
    end
    new_hash
  end

  def self.ratio_hash(season)
    new_hash = {}

    ratio = goals_and_shots(season)
    ratio.map do |key, value|
      new_hash[key] = (value[0].to_f / value[1].to_f)
    end
    new_hash
  end
end
