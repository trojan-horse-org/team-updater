require 'octokit'
require 'pathname'


def main

print ENV["MODIFIED_FILES"]
print ENV["ALL_MODIFIED_OR_CREATED_FILE_NAMES"]
github_token = ENV["GITHUB_TOKEN"]
modified_txt_files = ENV["MODIFIED_FILES"].split( ' ' ).select {| file | file.end_with?('.txt') }

  client = Octokit:: Client.new(access_token: github_token)
  repo = client.repository(repository)
  org = client.organization(repo.owner.login)

  modified_txt_files.each do | modified_file|
  team_name = File.basename(modified_file, '.txt')

  usernames = File.readlines(modified_file).map( & : strip)

    team = client.org_teams(org.login).find {| t | t.name == team_name }

    if team.nil?
    team = client.create_team(org.login, name: team_name, privacy: 'closed')
    client.add_team_repository(team.id, repository)
    end

    current_members = team.team_members(team.id).map( & : login)
    current_members.each {| member | client.remove_team_member(team.id, member) }
    usernames.each {| username | client.add_team_member(team.id, username) }

    puts "Team '#{team_name}' updated with #{usernames.size} members."
  end


end

main if __FILE__ == $PROGRAM_NAME
