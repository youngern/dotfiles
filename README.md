# Dotfiles

Dotfiles after onboarding from scratch

### Instructions:
After a fresh install on your machine:
1. Setup git, and clone this repo:
```bash
xcode-select --install
# this will restart your computer
# remove `--restart` if you don't want to do that right now
sudo softwareupdate -i -a --restart

git clone https://github.com/youngern/dotfiles.git "$HOME/.dotfiles"
```

2. Change user info to correct user in `config/git/config`
3. Run `make` in the root directory for this repo
4. Run `make restart`, some changes will require restart of your computer to take effect.

You'll need most packages / installation for this repo to get through onboarding.
However, some are by preference, so feel free to go through the directories and change anything.

A suggested flow would be:
- fork this repo
- clone to `$HOME/.dotfiles`
- commit any changes to VCS
- if you make any changes that may be beneficial to the rest of the team, make a PR.

### How this repo works

- This repo uses [`make`](https://www.gnu.org/software/make/manual/make.html) to orchestrate setup on a clean install of your machine.
- The files were written with preference to MacOS, so approach with caution if you are on a different machine.
- This dotfiles repo is meant to act as a source of truth for your own machine, so that when you make changes to it, you can commit it to VCS and take it with you to your next machine. This process is done via [`stow`](https://www.gnu.org/software/stow/).

### What the code does
1. Installs `homebrew` and libraries / applications installed via `brew`.
   - Packages are listed within `packages/Brewfile`. Feel free to add or remove anything. We tried to keep the list as short as possible while getting your machine everything it needs to hit the ground running.
2. Installs vscode extensions, located in `packages/Codefile`. If you prefer not to use VSCode, you can comment out this step and remove installation from `Brewfile`.
3. Sets up `ssh` for GitHub. This step will require _some_ manual work.
4. (MacOS) Updates system preferences, like language inputs, trackpad behavior, dock size, etc. Keep or change it to your own preferences in `macos/defaults`.
5. Installs `nvm`, the node package manager.
6. Links files in `runcom`, `config` and `Application Support` to respective directories on your machine. Now every time you make changes to your system files, it'll be under version control and you can take it with you on your next install.

### Directory Structure

- `Application Support` - Any settings for applications should be stored here. You probably don't want to store anything too large; a good example would be VSCode user settings, which is stored via JSON. 
- `config` - Any configuration that's meant to be located at `~/.config`
- `macos` - Configuration specific to MacOS. Adds input settings, trackpad preferences, etc.
- `runcom` - bash profiles, zsh profiles, and the like.
- `system` - Any functions or exports you want to load into your `*profile`. We keep them as separate files so the functions are organized and load them through a `source` call within `*profile`.
- `setup` - any one-off setups you might have to do, like setting up SSH config for git.
- `Makefile` - Used to run this repo. Running `make` will run the first command, and if any fail, you can run a specific one by passing in the name, i.e. `make <cmd>`
