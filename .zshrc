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
PROMPT='%B%F{red}[%D{%f/%m/%y} %D{%L:%M:%S}] %B%F{green}%n%B%F{green}|%B%F{green}%m%f %b%F{green}%~%f%b%B%F{green} #%F{white} '
PR_RST="%{${reset_color}%}"
