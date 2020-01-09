require 'csv'
require_relative 'game_team'
require_relative 'team'
require_relative 'game'
require_relative 'data_objects/incremental_average'

class Tackle

  def self.most_tackles(season)
    hash = get_most_tackles_hash(season)
    max = hash.max_by {|key, value| value}
    get_team_name_from_id(max[0])
  end

  def self.fewest_tackles(season)
    hash = get_most_tackles_hash(season)
    min = hash.max_by {|key, value| value}
    get_team_name_from_id(min[0])
  end

  def self.team_seasons
    hash = {}

    Game.all_games.map do |game|
      if hash.key?(game.season)
        hash[game.season] << game.game_id
      else
        hash[game.season] = game.game_id
      end
    end
    hash
  end

  def self.get_most_tackles_hash(season)
    new_hash = {}
    GameTeam.all_game_teams.map do |game_team|
      if team_seasons()[season].include?(game_team.game_id)
        if new_hash.key?(game_team.team_id)
          new_hash[game_team.team_id] = new_hash[game_team.team_id] + game_team.tackles.to_i
        else
          new_hash[game_team.team_id] = game_team.tackles.to_i
        end
      end
    end
    new_hash
  end

  def self.get_team_name_from_id(team_id)
    Team.all_teams.map do |team|
      if team_id == team.team_id
        return team.team_name
      end
    end
  end
end
