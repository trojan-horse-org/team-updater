# GitHub Teams Membership Updater

This GitHub Action updates GitHub teams' membership based on users listed in the `.txt` files. It is triggered by a pull request that has been merged into the main branch. The users listed in the `.txt` files will become members of the team with the same name as the file. If the team does not exist, the action will create it. If there are multiple `.txt` files, the users will be added to the corresponding teams. The script is written in Ruby.

## Setup


1. Create a new folder named teams in the root of your repository. Inside this folder, create a `.txt` file for each team you'd like to manage. Name the file after the team (e.g., `team1.txt`), and list the GitHub usernames of the team members, one per line:

``` txt 
 user1
 user2
 user3
```

2.  Commit and push these changes to your repository. The GitHub Action will trigger whenever a pull request is merged into the main branch. The action will create or update the GitHub teams with the same names as the modified `.txt` files and update the users' membership accordingly.
