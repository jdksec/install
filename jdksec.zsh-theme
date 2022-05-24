function prompt_char {
    echo '#'
}

function virtualenv_info {
    [[ -n "$VIRTUAL_ENV" ]] && echo '('${VIRTUAL_ENV:t}') '
}

PROMPT='%F{039}%n@%F{039}%m%f %B%F{039}%~%f%b$(git_prompt_info)$(ruby_prompt_info)
$(virtualenv_info)%F{039}$(prompt_char)%F{white} '

ZSH_THEME_GIT_PROMPT_PREFIX=' on %F{039}'
ZSH_THEME_GIT_PROMPT_SUFFIX='%f'
ZSH_THEME_GIT_PROMPT_DIRTY='%F{green}!'
ZSH_THEME_GIT_PROMPT_UNTRACKED='%F{green}?'
ZSH_THEME_GIT_PROMPT_CLEAN=''
PR_RST="%{${reset_color}%}"
ZSH_THEME_RUBY_PROMPT_PREFIX=' using %F{red}'
ZSH_THEME_RUBY_PROMPT_SUFFIX='%f'
