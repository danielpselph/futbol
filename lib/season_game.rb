require_relative 'game_team'
require_relative 'game'

class SeasonGame
  def self.all_season_games
    @@all_season_games ||= season_games
  end

  def self.all_post_season_games
    @@all_post_season_games ||= post_season_games
  end

  def self.all_regular_season_games
    @@all_regular_season_games ||= regular_season_games
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

  def self.post_season_games
    season_games = Game.all_games.reduce({}) do |season_games, game|
      season_games[game.season] = {}
      season_games
    end

    season_games.each do |season, games|
      games_for_post_season = Game.all_games.find_all do |game|
        season == game.season && game.type == "Postseason"
      end

      game_ids = games_for_post_season.map {|game| game.game_id}

      game_teams = GameTeam.all_game_teams.find_all do |game_team|
        game_ids.include?(game_team.game_id)
      end

      game_ids.each do |game_id|
        games[game_id] = game_teams.find_all {|game_team| game_team.game_id == game_id}
      end
    end
  end

  def self.regular_season_games
    season_games = Game.all_games.reduce({}) do |season_games, game|
      season_games[game.season] = {}
      season_games
    end

    season_games.each do |season, games|
      games_for_regular_season = Game.all_games.find_all do |game|
        season == game.season && game.type == "Regular Season"
      end

      game_ids = games_for_regular_season.map {|game| game.game_id}

      game_teams = GameTeam.all_game_teams.find_all do |game_team|
        game_ids.include?(game_team.game_id)
      end

      game_ids.each do |game_id|
        games[game_id] = game_teams.find_all {|game_team| game_team.game_id == game_id}
      end
    end
  end
end
