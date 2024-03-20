export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S - '
export PROMPT_COMMAND='history -a'
export HISTFILE=~/.history
export HISTSIZE=50000
export SAVEHIST=50000
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."



setopt hist_ignore_all_dups hist_save_nodups share_history hist_ignore_space hist_reduce_blanks hist_verify inc_append_history

function history-all {
    history -E 1
}
