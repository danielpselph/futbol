require_relative 'game_team'
require_relative 'game'
class SeasonGame

  def self.all_season_games
    @@all_season_games ||= season_games
  end

  def self.clear_all_season_games
    @@all_season_games = nil
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

      game_ids.each do |game_id|
        games[game_id] = game_teams.find_all {|game_team| game_team.game_id == game_id}
      end
    end
  end
end
