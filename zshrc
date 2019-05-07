# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/cmercier/.oh-my-zsh"

ZSH_THEME="avit"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh


# macOS only // map caps lock to escape
source $ZSH/oh-my-capslock.sh


export USER=cmercier
export MAIL=cmercier@student.42.fr

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias gww="gcc -W -Wall -Werror -Wextra"
alias norme="norminette -R CheckForbiddenSourceHeader"
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias rmrf="rm -rf"
