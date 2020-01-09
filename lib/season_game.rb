require_relative 'game_team'
require_relative 'game'
class SeasonGame #< Game
  # attr_reader :all_season_games
  def self.all_season_games
    @@all_season_games ||= season_games
    #@all_games = Game.all_games
  end
  def self.season_games
    season_games = Game.all_games.reduce({}) do |season_games, game|
      season_games[game.season] = {}
      season_games
    end
    season_games.each do |season, games|
      games_for_season = Game.all_games.find_all do |game|
        season == game.season
      end
      game_ids = games_for_season.map {|game| game.game_id}
      game_teams = GameTeam.all_game_teams.find_all do |game_team|
        game_ids.include?(game_team.game_id)
      end
      #game_ids == game_team.game_ids
      game_ids.each do |game_id|
        games[game_id] = game_teams.find_all {|game_team| game_team.game_id == game_id}
        # game_teams.each do |game_team|
        #   require "pry"; binding.pry
        #   if game_team.game_id == game_id
        #     season[games][game_id] = [game_team]
        #   end
        # end
      end
      # season_games[season][game.game_id] = game_teams
    end
    # season_games = Game.all_games.reduce({}) do |seasons, game|
    #   # if seasons.include?(game.season)
    #   #   game_teams[game.game_id] = nil
    #   #   seasons[game.season]
    #   # else
    #     game_teams[game.game_id] = []
    #     seasons[game.season] = game_teams #{game.game_id => nil}
    #   # else seasons[game.season] = {game.game_id => nil}
    #   # end
    #   # seasons
    #
    #   GameTeam.all_game_teams.each do |game_team|
    #     if game_team.game_id == game.game_id
    #     # && seasons.values.pop[game.game_id] == nil
    #     #   seasons.values.pop[game.game_id] = [game_team]
    #     # elsif game_team.game_id == game.game_id && seasons.values.pop[game.game_id] != nil
    #       season_game = seasons.values.find do |season_game|
    #         season_game.keys.include?(game.game_id)
    #       end
    #       season_game[game.game_id] << game_team
    #     end
    #     #game_teams[seasons.values.pop[game.game_id]] = game_team
    #   end
    #   require "pry"; binding.pry
    #   seasons
    # end
    # season_games
  end
end
