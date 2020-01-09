require_relative 'game_team'

class WinsAndTies
  def self.percentage_home_wins
    count_game = 0
    count_win = 0
    
    GameTeam.all_game_teams.each do |game_team|
      if game_team.result == "WIN" && game_team.hoa == "home"
        count_game += 1
        count_win += 1
      elsif (game_team.result == "LOSS" || game_team.result == "TIE") && game_team.hoa == "home"
        count_game += 1
      end
    end
    
    (count_win/count_game.to_f).round(2)
  end

  def self.percentage_visitor_wins
    count_game = 0
    count_win = 0
    
    GameTeam.all_game_teams.each do |game_team|
      if game_team.result == "WIN" && game_team.hoa == "away"
        count_game += 1
        count_win += 1
      elsif (game_team.result == "LOSS" || game_team.result == "TIE") && game_team.hoa == "away"
        count_game += 1
      end
    end
    
    (count_win/count_game.to_f).round(2)
  end

  def self.percentage_ties
    total_games = GameTeam.all_game_teams.map {|game_team| game_team.game_id}.uniq.length
    count_tie = 0
    
    GameTeam.all_game_teams.each {|game_team| count_tie += 1 if game_team.result == "TIE" && game_team.hoa == "home"}
    
    (count_tie/total_games.to_f).round(2)
  end
  
  def self.winningest_team
    team_wins = {}
    team_losses = {}
    team_ties = {}
    total_games = {}
    win_percentages = {}
    
    GameTeam.all_game_teams.each do |game|
      if !team_wins.include?(game.team_id)
        team_wins[game.team_id] = 0
        team_losses[game.team_id] = 0
        team_ties[game.team_id] = 0
      end
      
      if game.result == "WIN"
        team_wins[game.team_id] += 1
      elsif game.result == "LOSS"
        team_losses[game.team_id] += 1
      else
        team_ties[game.team_id] += 1
      end
      
      total_games[game.team_id] = team_wins[game.team_id] + team_losses[game.team_id] + team_ties[game.team_id]
      
      win_percentages[game.team_id] = (team_wins[game.team_id] / total_games[game.team_id].to_f).round(3)
    end
    
    winningest_team_id = win_percentages.key(win_percentages.values.max)
    
    Team.all_teams.find do |team|
      team.team_id == winningest_team_id
    end.team_name
  end
end