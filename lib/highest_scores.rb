require_relative 'game_team'

class HighestScores
  def self.highest_scoring_visitor
    goals_team = {}
    games_team = {}
    goal_count = 0
    game_count = 0
    visitors = GameTeam.all_game_teams.find_all {|game_team| game_team.hoa == "away"}
    visitors_sorted = visitors.sort_by(&:team_id)

    visitors_sorted.each do |visitor|
      if goals_team.keys.include?(visitor.team_id) == false
        goals = 0
        goals_team[visitor.team_id] = (goals += visitor.goals.to_i)
        game_count = 0
        games_team[visitor.team_id] = (game_count += 1)
      else
        goals_team[visitor.team_id] = (goals_team[visitor.team_id] += visitor.goals.to_i)
        games_team[visitor.team_id] = (game_count += 1)
      end
    end

    avg_goal_team = {}
    games_team.keys.each do |key|
      avg_goal_per_game = (goals_team[key]/games_team[key].to_f).round(4)
      avg_goal_team[key] = avg_goal_per_game
    end
    
    max_team = avg_goal_team.max_by do |goal|
      goal[-1]
    end
    max_team.first
    team_name = ""
    Team.all_teams.each do |team_param|
      team_name = team_param.team_name if max_team.first == team_param.team_id
    end
    team_name
  end
  
  def self.highest_scoring_home_team
    goals_team = {}
    games_team = {}
    goal_count = 0
    game_count = 0
    homes = GameTeam.all_game_teams.find_all {|game_team| game_team.hoa == "home"}
    homes_sorted = homes.sort_by(&:team_id)

    homes_sorted.each do |home|
      if goals_team.keys.include?(home.team_id) == false
        goals = 0
        goals_team[home.team_id] = (goals += home.goals.to_i)
        game_count = 0
        games_team[home.team_id] = (game_count += 1)
      else
        goals_team[home.team_id] = (goals_team[home.team_id] += home.goals.to_i)
        games_team[home.team_id] = (game_count += 1)
      end
    end

    avg_goal_team = {}
    games_team.keys.each do |key|
      avg_goal_per_game = (goals_team[key]/games_team[key].to_f).round(4)
      avg_goal_team[key] = avg_goal_per_game
    end
    max_team = avg_goal_team.max_by do |goal|
      goal[-1]
    end
    max_team.first
    team_name = ""
    Team.all_teams.each do |team_param|
      team_name = team_param.team_name if max_team.first == team_param.team_id
    end
    team_name
  end
end