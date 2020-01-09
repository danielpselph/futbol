require 'csv'

class Game
  @@all_games

  def self.all_games
    @@all_games
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @@all_games = csv.map do |row|
      Game.new(row)
    end
  end

  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue

  def initialize(game_info)
    @game_id = game_info[:game_id]
    @season = game_info[:season]
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id]
    @home_team_id = game_info[:home_team_id]
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @venue = game_info[:venue]
  end

  def self.count_of_games_by_season
    season_games = {}
    number_of_games = 0
    all_games_sorted = @@all_games.sort_by(&:season)

    all_games_sorted.each do |game|
      if season_games.keys.include?(game.season) == false
        number_of_games = 0
        season_games[game.season] = (number_of_games += 1)
      else
        season_games[game.season] = (number_of_games += 1)
      end
    end

    season_games
  end

  def self.average_goals_by_season
    season_avg_goals = {}
    total_games_per_season = 0
    all_games_sorted = @@all_games.sort_by(&:season)

    all_games_sorted.each do |game|
      if season_avg_goals.keys.include?(game.season) == false
        total_games_per_season = 0
        season_avg_goals[game.season] = total_games_per_season = total_games_per_season + game.away_goals + game.home_goals
      else
        season_avg_goals[game.season] =
        total_games_per_season = total_games_per_season + game.away_goals + game.home_goals
      end
    end

    counter = -1

    averages = season_avg_goals.values.map do |goals_total|
    (goals_total / count_of_games_by_season.values[counter += 1].to_f).round(2)
    end

    counter = -1

    season_avg_goals.keys.each do |key|
      season_avg_goals[key] = averages[counter += 1]
    end

    season_avg_goals
  end

  def self.average_goals_per_game
    number_of_games = @@all_games.map {|game| game.game_id}.count
    total_goals = @@all_games.map {|game| game.away_goals + game.home_goals}.sum
    
    (total_goals / number_of_games.to_f).round(2)
  end
end