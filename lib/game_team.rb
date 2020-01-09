require 'csv'
require_relative 'team'
require_relative 'game'

class GameTeam
  @@all_game_teams

  def self.all_game_teams
    @@all_game_teams
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @@all_game_teams = csv.map do |row|
      GameTeam.new(row)
    end
  end

  attr_reader :game_id, :team_id, :hoa, :result, :settled_in,
              :head_coach, :goals, :shots, :tackles

  def initialize(game_team_info)
    @game_id = game_team_info[:game_id]
    @team_id = game_team_info[:team_id]
    @hoa = game_team_info[:hoa]
    @result = game_team_info[:result]
    @settled_in = game_team_info[:settled_in]
    @head_coach = game_team_info[:head_coach]
    @goals = game_team_info[:goals]
    @shots = game_team_info[:shots]
    @tackles = game_team_info[:tackles]
  end
end
