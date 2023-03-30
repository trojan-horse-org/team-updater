require 'octokit'
require 'pathname'

def main
  github_token = ENV["GITHUB_TOKEN"]
  repository = ENV["REPOSITORY"]
  modified_files = ARGV[0].split

  client = Octokit::Client.new(access_token: github_token)
  repo = client.repository(repository)
  org = client.organization(repo.owner.login)

  modified_files.each do |modified_file|
    team_name = File.basename(modified_file, '.txt')

    usernames = File.readlines(modified_file).map(&:strip)

    team = client.org_teams(org.login).find { |t| t.name == team_name }

    if team.nil?
      team = client.create_team(org.login, name: team_name, privacy: 'closed')
      client.add_team_repository(team.id, repository)
    end

    current_members = client.team_members(team.id).map(&:login)
    current_members.each { |member| client.remove_team_member(team.id, member) }
    usernames.each { |username| client.add_team_member(team.id, username) }

    puts "Team '#{team_name}' updated with #{usernames.size} members."
  end
end

main if __FILE__ == $PROGRAM_NAME
