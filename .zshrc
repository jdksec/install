autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
HISTFILE=~/.zsh_history
HISTSIZE=100000000000
SAVEHIST=100000000000
setopt SHARE_HISTORY
setopt inc_append_history
alias history='history -f'
source ~/.zprofile
alias l='ls -a1'
alias ls='ls -a1'
export PATH=$PATH:/usr/local/go/bin
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/install/bins:$PATH
PROMPT='%B%F{092}[%D{%f/%m/%y} %D{%T}] %B%F{092}%n%B%F{092}|%B%F{092}%m%f %b%F{092}%~%f%b%B%F{092} #%F{white} '
PR_RST="%{${reset_color}%}"
TMOUT=1
TRAPALRM() {
    zle reset-prompt
}
