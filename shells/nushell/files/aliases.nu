# download link with yt-dlp and extract mp3 audio only
export def mp3 [url: string] {
    yt-dlp -i --extract-audio --audio-format mp3 $url
}

