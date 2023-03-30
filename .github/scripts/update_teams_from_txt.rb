require 'octokit'

def main
  github_token = ENV["GITHUB_TOKEN"]
  repository = ENV["REPOSITORY"]
  modified_files = ARGV[0].split

  client = Octokit::Client.new(access_token: github_token)
  repo = client.repository(repository)
  org = client.organization(repo.owner.login)

  modified_files.each do |modified_file|
    next unless File.extname(modified_file) == '.txt'

    team_name = File.basename(modified_file, '.txt')

    usernames = File.readlines(modified_file).map(&:strip)

    team = client.org_teams(org.login).find { |t| t.name == team_name }

    if team.nil?
      team = client.create_team(org.login, name: team_name, privacy: 'closed')
      client.add_team_repository(team.id, repository)
    end

    current_members = client.team_members(team.id).map(&:login)
    members_to_remove = current_members - usernames
    members_to_add = usernames - current_members

    members_to_remove.each { |member| client.remove_team_member(team.id, member) }
    members_to_add.each { |username| client.add_team_member(team.id, username) }

    puts "Team '#{team_name}' updated: #{members_to_add.size} members added, #{members_to_remove.size} members removed."
  end
end

main if __FILE__ == $PROGRAM_NAME
