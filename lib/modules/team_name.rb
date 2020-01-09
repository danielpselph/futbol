require_relative '../team'

module TeamName

  def get_team_name_from_id(team_id)
    Team.all_teams.map {|team| return team.team_name if team_id == team.team_id}
  end

  # @@all_teams
  #
  # def get_all_teams()
  #   if(@@all_teams == nil)
  #     @@all_teams = generate()
  #   end
  #   return @@all_teams
  # end 
end
