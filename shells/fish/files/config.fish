if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting ""
end

# prompt engine
# https://starship.rs/
starship init fish | source

# command-line fuzzy finder 
# https://github.com/junegunn/fzf
fzf --fish | source

# fly through shell history
# https://github.com/cantino/mcfly
mcfly init fish | source

# smarter cd command
# https://github.com/ajeetdsouza/zoxide
zoxide init fish | source
alias cd="z"

alias ls="eza --icons=always"

# set the TTY for GnuPG
set -gx GPG_TTY (tty)

abbr --add get_idf '. $HOME/esp/esp-idf/export.sh'
abbr --add update-submodules 'git submodule sync; git submodule update --init'
abbr --add mp3 "yt-dlp -i --extract-audio --audio-format mp3 $1"
abbr --add scpresume "rsync --partial --progress "
abbr --add reload exec fish
abbr --add ducks "du -cks -- * | sort -rn | head"


# Port Forwarding
#
# used when no port forwarding is possible on the router
# forward 'localhost:8080' to '172.22.5.1:9092'
abbr --add forward "ssh home -L localhost:9090:172.22.5.1:8989"


# Reverse Port Forwarding
#
# used to publish a webpage to the internet
abbr --add backward "ssh -R 80:localhost:3000 serveo.net"


# Dynamic Port Forwarding
#
# used when a web blocker is used
# Enter 'localhost:8181' as socks proxy in your browser
# needs 'AllowTcpForwarding' & 'PermitOpen' enabled in /etc/sshd_config
#
# -C (compression)
# -N (no remote commands)
# -f (background process)
abbr --add socks "ssh home -fNC -D 9090"


# Reverse
#
# used to access a computer connected from remote
# needs 'AllowTcpForwarding' & 'GatewayPorts' enabled in /etc/sshd_config
#
# -C (compression)
# -N (no remote commands)
# -f (background process)
abbr --add tunnel "ssh home -fNC -R 9000:localhost:80"



source ~/.config/fish/git.fish
source ~/.config/fish/path.fish
source ~/.config/fish/tokyonight_night.fish

# Vim keybindings in the terminal
fish_vi_key_bindings
