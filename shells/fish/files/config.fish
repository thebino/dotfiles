if status is-interactive
    # Commands to run in interactive sessions can go here
end

# promt theme engine
# https://ohmyposh.dev/
oh-my-posh init fish | source

# command-line fuzzy finder 
# https://github.com/junegunn/fzf
fzf --fish | source

# fly through shell history
# https://github.com/cantino/mcfly
mcfly init fish | source

abbr --add get_idf '. $HOME/esp/esp-idf/export.sh'
abbr --add update-submodules 'git submodule sync; git submodule update --init'
abbr --add mp3 "yt-dlp -i --extract-audio --audio-format mp3 $1"
abbr --add scpresume "rsync --partial --progress "
abbr --add reload exec fish

