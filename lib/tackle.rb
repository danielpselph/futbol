require 'csv'
require_relative 'game_team'
require_relative 'team'
require_relative 'game'
require_relative 'data_objects/incremental_average'
require_relative 'season_game'
require_relative 'modules/team_name'

class Tackle < SeasonGame
  extend TeamName

  def self.most_tackles(season)
    hash = get_most_tackles_hash(season)
    max = hash.max_by {|key, value| value}
    get_team_name_from_id(max[0])
  end

  def self.fewest_tackles(season)
    hash = get_most_tackles_hash(season)
    min = hash.min_by {|key, value| value}
    get_team_name_from_id(min[0])
  end

  def self.get_most_tackles_hash(season)
    new_hash = {}

    tackle_hash = all_season_games[season]

    GameTeam.all_game_teams.map do |game_team|
      if tackle_hash.keys.include?(game_team.game_id)
        if new_hash.key?(game_team.team_id)
          new_hash[game_team.team_id] = new_hash[game_team.team_id] + game_team.tackles.to_i
        else
          new_hash[game_team.team_id] = game_team.tackles.to_i
        end
      end
    end
    new_hash
  end
end
