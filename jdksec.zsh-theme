function prompt_char {
    echo '#'
}

function virtualenv_info {
    [[ -n "$VIRTUAL_ENV" ]] && echo '('${VIRTUAL_ENV:t}') '
}

PROMPT='%F{166}%n%f at %F{118}%m%f in %B%F{green}%~%f%b$(git_prompt_info)$(ruby_prompt_info)
$(virtualenv_info)%F{166}$(prompt_char)%F{white} '

ZSH_THEME_GIT_PROMPT_PREFIX=' on %F{50}'
ZSH_THEME_GIT_PROMPT_SUFFIX='%f'
ZSH_THEME_GIT_PROMPT_DIRTY='%F{green}!'
ZSH_THEME_GIT_PROMPT_UNTRACKED='%F{green}?'
ZSH_THEME_GIT_PROMPT_CLEAN=''
PR_RST="%{${reset_color}%}"
ZSH_THEME_RUBY_PROMPT_PREFIX=' using %F{red}'
ZSH_THEME_RUBY_PROMPT_SUFFIX='%f'
