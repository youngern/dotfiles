SHELL = /bin/zsh
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
NVM_DIR := $(HOME)/.nvm
export XDG_CONFIG_HOME = $(HOME)/.config
export APPLICATION_SUPPORT_HOME = $(HOME)/Library/Application\ Support
export STOW_DIR = $(DOTFILES_DIR)

install: editor link packages core

core: git-ssh defaults npm

packages: install-brew install-brew-packages vscode-extensions

install-brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	. $(DOTFILES_DIR)/runcom/.zprofile

install-brew-packages:
	brew bundle --file=packages/Brewfile

npm:
	if ! [ -d $(NVM_DIR)/.git ]; then git clone https://github.com/creationix/nvm.git $(NVM_DIR); fi
	. $(NVM_DIR)/nvm.sh; nvm install --lts

git-ssh:
	. $(DOTFILES_DIR)/setup/git-ssh

vscode-extensions:
	$(info    setting up vscode extensions)
	for EXT in $$(cat packages/Codefile); do code --install-extension $$EXT; done
	stow -t $(APPLICATION_SUPPORT_HOME) "Application Support"

defaults:
	$(info    setting up osx defaults)
	. $(DOTFILES_DIR)/macos/defaults

editor:
	$(info    setting up terminal plugin)
	. $(DOTFILES_DIR)/setup/oh-my-zsh

link:
	$(info    linking files)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config

restart:
	sudo shutdown -r now
