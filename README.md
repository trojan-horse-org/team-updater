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

## A word on using this script with self-hosted runners

It might be the case that for your runner you need to install various tools to make the `ruby/setup-ruby` run smoothly in your workflow.

Here are the steps to follow on the command line to set up the necessary dependencies for the `ruby/setup-ruby` action on your GitHub Actions runner:

#### Install Ruby:

On Ubuntu/Debian-based systems, you can install Ruby using the following command:

```
sudo apt-get update
sudo apt-get install ruby-full
```

On CentOS/RHEL-based systems, you can install Ruby using the following command:

```
sudo yum install ruby
```

On macOS, you can install Ruby using Homebrew with the following command:

```
brew install ruby
```

You can also download and install Ruby manually from the Ruby website: <https://www.ruby-lang.org/en/downloads/>.

#### Install Bundler:

Once you have installed Ruby, you can install Bundler using the following command:

```
gem install bundler
```

#### Install Git:

On Ubuntu/Debian-based systems, you can install Git using the following command:


```
sudo apt-get update
sudo apt-get install git
```

On CentOS/RHEL-based systems, you can install Git using the following command:

```
sudo yum install git
```

On macOS, you can install Git using Homebrew with the following command:

```
brew install git
```

Once you have installed these dependencies on your runner, you should be able to use the ruby/setup-ruby action to set up Ruby for your GitHub Actions workflows.
