require 'csv'
require_relative 'team'
require_relative 'game_team'
require_relative 'data_objects/incremental_average'

class Offense

  def self.count_of_teams
    count = []
    Team.all_teams.map do |game_team|
      count << game_team.team_id
    end
    count.length
  end

  def self.best_offense
    hash = get_team_goal_avg_hash()

    current_max_team_id = ""
    current_max_avg = -1
    hash.map do |team_id, avg|
      if(avg.average > current_max_avg)
        current_max_team_id = team_id
        current_max_avg = avg.average
      end
    end
    get_team_name_from_id(current_max_team_id)
  end

  def self.add_goals_to_team(team_id, sample, hash)
    if hash.key?(team_id)
      hash[team_id].add_sample(sample)
    else
      hash[team_id] = IncrementalAverage.new(sample)
    end
  end

  def self.get_team_name_from_id(team_id)
    Team.all_teams.map do |team|
      if team_id == team.team_id
        return team.team_name
      end
    end
  end

  def self.get_team_goal_avg_hash
    hash = {}
    GameTeam.all_game_teams.map do |game_team|
      add_goals_to_team(game_team.team_id, game_team.goals.to_f, hash)
    end
    hash
  end

  def self.worst_offense
    hash = get_team_goal_avg_hash()

    current_min_team_id = ""
    current_min_avg = nil
    hash.map do |team_id, avg|
      if current_min_avg == nil
        current_min_avg = avg.average
      elsif (avg.average < current_min_avg)
        current_min_team_id = team_id
        current_min_avg = avg.average
      end
    end
    get_team_name_from_id(current_min_team_id)
  end
end
