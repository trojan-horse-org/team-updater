import os
import sys
from github import Github

def main():
    # Authenticate with GitHub API using the provided token
    gh = Github(os.environ["GITHUB_TOKEN"])

    # Get repository information
    repo = gh.get_repo(os.environ["REPOSITORY"])

    # Get modified file name(s) from input
    modified_files = sys.argv[1:]

    for modified_file in modified_files:
        # Get team name from .txt file name
        team_name = os.path.basename(modified_file).replace(".txt", "")

        # Read the .txt file and parse usernames
        with open(modified_file, "r") as f:
            usernames = [line.strip() for line in f]

        # Get or create the team with the provided team_name
        team = None
        for t in repo.get_teams():
            if t.name == team_name:
                team = t
                break

        if team is None:
            org = repo.organization
            team = org.create_team(name=team_name, repo_names=[repo.full_name])

        # Clear current team members
        for member in team.get_members():
            team.remove_membership(member)

        # Add new members from the parsed usernames list
        for username in usernames:
            user = gh.get_user(username)
            team.add_membership(user, role="member")

        print(f"Team '{team_name}' updated with {len(usernames)} members.")

if __name__ == "__main__":
    main()
