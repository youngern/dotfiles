install: install-brew

install-brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

install-cask-apps:
	brew bundle --file=packages/Caskfile
