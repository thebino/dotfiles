setopt auto_menu
unsetopt menu_complete
setopt prompt_subst auto_resume nobeep clobber auto_cd auto_pushd pushd_ignore_dups list_packed noautoremoveslash nolistbeep extended_glob interactive_comments

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT
