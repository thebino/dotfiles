export ZSH="$HOME/.oh-my-zsh"

# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="awesomepanda"

# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins#plugins
plugins=(
  git
  ant
  github
  history-substring-search
  adb
)

# Init script
source $ZSH/oh-my-zsh.sh

# custom scripts
source $HOME/.zsh/alias.zsh
# source $HOME/.zsh/android.zsh
# source $HOME/.zsh/colors.zsh
# source $HOME/.zsh/env.zsh
# source $HOME/.zsh/github.zsh
# source $HOME/.zsh/history.zsh
# source $HOME/.zsh/java.zsh
# source $HOME/.zsh/keybinding.zsh
# source $HOME/.zsh/locale.zsh
# source $HOME/.zsh/motd.zsh
# source $HOME/.zsh/options.zsh
# source $HOME/.zsh/private.zsh
# source $HOME/.zsh/terminal.zsh
