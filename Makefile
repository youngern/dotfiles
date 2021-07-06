SHELL = /bin/zsh
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
export XDG_CONFIG_HOME = $(HOME)/.config
export APPLICATION_SUPPORT_HOME = $(HOME)/Library/Application\ Support
export STOW_DIR = $(DOTFILES_DIR)

install: install-brew

install-brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

install-cask-apps:
	brew bundle --file=packages/Caskfile

install-brew-packages:
	brew bundle --file=packages/Brewfile

defaults:
	. $(DOTFILES_DIR)/macos/defaults

link:
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config
	stow -t $(APPLICATION_SUPPORT_HOME) "Application Support"

restart:
	sudo shutdown -r now
