alias reload='source $HOME/.zshrc'

alias cls='clear'

alias la='ls -a'
alias ll='ls -la'

alias cd..='cd ..'
alias ..='cd ../'
alias ...='cd ../../'
alias mkdir='mkdir -p'


alias cp='cp -iv'
alias mv='mv -iv'


alias df='df -h'
alias du='du -cksh'
alias dus='du -ms * | sort -n'

alias get='curl -O'
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"

alias get_idf='. $HOME/esp/esp-idf/export.sh'

alias egrep='egrep --color=auto'
alias eject='drutil tray eject'
alias fgrep='fgrep --color=auto'

alias grep=egrep
alias grpe=grep
alias nano='nano -c'
alias noascii="sed 's/.\\[[0-9][0-9]?m//g'"

alias quote="sed -Ee $'s/([ \'\"])/\\\\\\\\\\\1/g'"
alias sed='sed -E'
alias sudo='sudo ' # Make sure aliases are expanded when using sudo.
alias tree="tree -A -I 'CVS|*~'"
alias update-submodules='git submodule sync; git submodule update --init'
alias vdir='vdir --color=auto'
alias wgethtml='wget -E -H -k -K -p -nd -o logwget.txt'

alias mp3="yt-dlp -i --extract-audio --audio-format mp3 $1"

alias scpresume="rsync --partial --progress "

alias me="echo $(whoami) "@" $(hostname) "with" $(ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2)"
alias json "python -m json.tool"

# Quickly serve the current directory as HTTP
# alias serve='ruby -run -e httpd . -p 8000'
alias serve='python3 -m http.server 8000'

video-to-gif() {
  # generate a color palette to be used to generate a much higher quality GIF 
  ffmpeg -i $1 -filter_complex "[0:v] palettegen" palette.png &&
  ffmpeg -i $1 -i palette.png -filter_complex "[0:v][1:v] paletteuse" output.gif &&
  echo '\n\noutput.gif created!'
}

# return the bitrate of a given file. eg: # bitrate foo.avi
# brew install libav
function bitrate () {
 avprobe -show_format "$1" 2> /dev/null | grep "bit_rate" | sed 's/.*bit_rate=\([0-9]\+\).*/\1/g';
}


function google {
  open "https://www.google.com/#q=$1"
}

function rs {
  open "https://doc.rust-lang.org/std/?search=$1"
}
