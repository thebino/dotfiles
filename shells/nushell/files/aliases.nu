# download link with yt-dlp and extract mp3 audio only
export def mp3 [url: string] {
    yt-dlp -i --extract-audio --audio-format mp3 $url
}

#
# GIT
#
export alias ga = git add
export alias gf = git fetch
export alias gl = git pull
export alias gr = git reset $"origin/$(git_current_branch)" --hard
export alias gs = git status --short --branch
export alias us = git submodule sync and git submodule update --init
export alias gcount = git shortlog --summary --numbered

export alias gbs = git bisect
export alias gbsb = git bisect bad
export alias gbsg = git bisect good
export alias gbsr = git bisect reset
export alias gbss = git bisect start
export alias difftastic = difft


export alias rsyncresume = rsync --partial --progress
export alias speedtest = wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip
export alias serve = python3 -m http.server 8000

