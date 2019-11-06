# Git Workflow


## Overview
We will have 2 long running branches named master and develop.

master	-------o---------------------------
develop	-------o------o-----o-----o-----

The idea is that the last commit on master is analogous to the product that is in stores right now, like a car you can buy in a showroom. And the last commit on develop is the state of the latest prototype in the R&D lab.

When you clone the project for the first time, you want to create a new branch off from develop. You then commit your work along this branch. When you're ready to have your feature integrated, you push your branch up, and submit a request to have your work integrated.



## Ephemeral Branch Pattern
When you 'push', the thing you are pushing is a branch. Same with pulling. When you push your feature branch to origin, that branch gets created in origin. Now origin will look like this:

master	-------o---------------------------
develop	-------o------o-----o-----o-----
muji-feature					  \-----o-----o-----o

Now the feature branch needs to be merged into the develop branch. Another way of saying that is from develop, we need to pull the feature branch in. That is, we want to do this:

master	-------o---------------------------
develop	-------o------o-----o-----o-----------------------------o------
muji-feature				           \-----o-----o-----o-------/

Now the last commit on develop has your new feature included. The feature branch is said to be ephemeral, because once it's merged in, it'll typically be deleted from the origin repo (and you should also then delete that branch from your local repo).



## Protection Pattern
When multiple people are working to create a product, the pattern is they branch off the latest version of develop, go off doing their thing, then come back and have their work integrated in by someone else.

Protections are placed to prevent people from merging (or pushing) into any branch they like, accidentally or not. It also facilitates a code review workflow, as someone has to vet the code before it can be merged in. These protections are generally placed on master and develop, so I've enabled them for our project too.

So, you push your branch, and request that it be integrated. This is called a pull request. The idea is that some manager / architect will see your new component you've made, then they'll say "hmm yeah this looks good" and they'll approve the request by pulling your branch in. Pull requests aren't actually a git feature; they're a feature of GitHub.



## High Level Steps
- You clone the repo (only at the beginning)
- You create your own branch off of the develop branch
- You make your commits along there
- When you're done, you push your branch up
- Then you go on GitHub and request that your branch be pulled in
- When the request is approved, your branch gets merged into develop, and will then be deleted from the origin. You should then delete your branch from your local repo as well.
- You switch to the develop branch, and pull to get the latest prototype
- Branch off and repeat.



## Setup Instructions
1. Open Xcode
2. Configure your Git credentials in the Preferences > Source Control tab.
3. Connect your GitHub account with Xcode in the Preferences > Accounts tab.
4. Close and reopen Xcode, you'll get the welcome screen. Choose 'Clone an existing project' and then select the repo from there (you'll see a list of repos that your GitHub account has access to) 



## Git Workflow Instructions
These instructions cover how to:
- branch off from another branch
- commit
- push a branch to origin
- make a pull request
- switch between branches
- delete a branch
- pull a branch from origin

Those are all the actions that are needed for this workflow, and all can be done via Xcode and GitHub; command line not needed.

When the project opens, the navigator is the column on the left that shows the project files. There are tabs above that; the first one is what shows the project files. The second is the git tab. Click that and look for the branches. It will tell you which branch you're currently on.


### Branching
Right click the develop branch and choose 'branch from', then enter the name of your new branch. That new branch then becomes the current one. Now you work on your stuff. Commits you make will be made on this branch.


### Viewing Your Changes
As you create new files, or make edits to existing files, you'll see symbols appear in the project files section: A (for added), M (for modified), and R (for renamed or restructured). When you're viewing a code file, you'll also see blue highlights in the margins to tell you what parts you've added/changed that have yet to be committed.


### Commits
When you're ready to make a commit, there are 2 ways to do it. You can manually select one or multiple changed files, right click and commit. Or you can go to Source Control > Commit, which will automatically select ALL the changes for you.

Note that when you add or rename a file, the root Xcode Project file will get marked with an M (for modified). If you are committing things manually, you should include that root file as well.


### Pushing Your Branch
When you want to push your branch, go to the main toolbar at the top, Source Control > Push. It is going to push whatever branch you're currently on.

Check that origin/your-feature-branch-name is selected (this is automatically set). Also check that it says 'create' in brackets, which means it will be creating this branch in the origin. If it doesn't, it means there's already a branch in origin with the same name. In that case, you would need to branch off your current branch, give it a unique name, and push that one.


### Branch Naming Convention
Use your first name as a prefix when naming new branches, so we don't run into that problem. And don't put feature details in the name of your branch; when you make a pull request, you get to include a title and description there. So something like kirk-feature is fine for a branch name.


### Making a Pull Request
Go to the project repo page on GitHub, and click on branches. Select the 'Your' tab to see your branches. Press the 'new pull request' button next to the branch you want integrated.

Then enter a title and description. By default, the title gets set to your last commit message, so replace it with a more general title that encompasses the whole branch work.

A pull request creates a sort of thread where things can be discussed, and you'll see messages when the request has been approved.


### Switching Branches
Once you see on the pull request thread that your branch was merged in and then deleted from origin, go to Xcode, right click the develop branch and click 'checkout' to switch to that branch.


### Deleting A Branch
Then right click your feature branch and choose delete.


### Pulling
Go to Source Control > Pull, and then select the develop branch. Note that if you are on your feature branch, and you pull develop, and then you switch to develop, you won't actually see any differences. You have to switch to a branch first, and then pull it.



## Extra Notes
When you select a branch in Xcode, you can see the commits made on that branch. However, when your feature branch is merged in to develop, and then you delete your local feature branch, switch to develop, and pull, Xcode won't show you the commits you made. It'll only show the merge commits. But don't worry, when you run git log in the command line, all your commits and messages are still there (and they're also in the origin repo).



## Useful Links

About the Git Workflow:
https://www.youtube.com/watch?v=aJnFGMclhU8

About Xcode's Git Features:
https://developer.apple.com/videos/play/wwdc2018/418/
https://developer.apple.com/videos/play/wwdc2017/405/
