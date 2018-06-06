
dotfiles = \
	.aliases\
	.bash_logout\
	.bash_profile\
	.bash_prompt\
	.bashrc\
	.curlrc\
	.editorconfig\
	.emacs.d\
	.exports\
	.functions\
	.gdbinit\
	.gitattributes\
	.gitconfig\
	.gitignore\
	.gvimrc\
	.hgignore\
	.hushlogin\
	.inputrc\
	.profile\
	.screenrc\
	.ssh\
	.tmux.conf\
	.vim\
	.vimrc\
	.wgetrc

brewapps = \
	python\
	python2

caskapps = \
	google-chrome\
	google-backup-and-sync\
	emacs\
	sketchup-pro\
	whatsapp

setup: brew bash dotfiles brewapps caskapps prefs

brew: 
	which brew 2>/dev/null || /usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew upgrade

# Install bash and set it as default shell
bash:
	brew install bash bash-completion2
	if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then echo '/usr/local/bin/bash' | sudo tee -a /etc/shells; chsh -s /usr/local/bin/bash; fi


dotfiles:
	rsync -avh --no-perms ${dotfiles} ~
	source ~/.bash_profile

brewapps: 
	brew install $(brewapps)

caskapps:
	brew cask install $(caskapps)

prefs:

~/Library/Preferences/com.apple.Terminal.plist: com.apple.Terminal.plist
	cp -f $^ $@
	defaults read com.apple.Terminal>/dev/null # force Terminal to flush its plist cache


#
# Set defaults and preferences
#
prefs: dock-prefs finder-prefs nvram-prefs screensaver-prefs device-prefs


# Dock Preferences
# Hot corners:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 'tr' = top right, 'br' = bottom right, etc.
dock-prefs:
	defaults write com.apple.dock autohide -bool true			# auto hide
	defaults write com.apple.dock wvous-tr-corner -int 2			# Mission Control
	defaults write com.apple.dock wvous-tr-modifier -int 0
	defaults write com.apple.dock wvous-br-corner -int 10			# Display Sleep
	defaults write com.apple.dock wvous-br-modifier -int 0
	defaults write com.apple.dock wvous-bl-corner -int 4			# Desktop
	defaults write com.apple.dock wvous-bl-modifier -int 0			
	defaults write com.apple.dock minimize-to-application -bool true	# Minimize to app icon
	killall Dock

# Finder Preferences:
# - hide files from Desktop
# - add Quit menu item: ⌘ + Q will also hide desktop icons
finder-prefs:
	defaults write com.apple.finder CreateDesktop false			# Hide all desktop icons
	defaults write com.apple.finder QuitMenuItem -bool true			# add Quit item
	killall Finder

# nvram Preferences:
# - silent boot (unreliable)
nvram-prefs:
	sudo nvram SystemAudioVolume=" "

# Screensaver Preferences
screensaver-prefs:
	defaults write com.apple.screensaver askForPassword -bool true
	defaults write com.apple.screensaver askForPasswordDelay 1200
	defaults write com.apple.screensaver idleTime 120
	defaults read com.apple.screensaver >/dev/null
	osascript -e 'tell application "System Preferences" to quit'


# Device Preferences
device-prefs:
	defaults write NSGlobalDomain KeyRepeat -int 2				# fast repeat
	defaults write NSGlobalDomain InitialKeyRepeat -int 15			# no delay
	defaults write NSGlobalDomain com.apple.trackpad.scaling -int 3		# fast tracking
