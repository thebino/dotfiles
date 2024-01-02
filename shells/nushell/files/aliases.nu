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
