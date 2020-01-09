require 'csv'

class Team
  @@all_teams

  def self.all_teams
    @@all_teams
  end
  
  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @@all_teams = csv.map do |row|
      Team.new(row)
    end
  end

  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium

  def initialize(team_info)
    @team_id = team_info[:team_id]
    @franchise_id = team_info[:franchiseid]
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
  end
end
