function prompt_char {
    echo 'λ'
}

PROMPT='%{$fg[red]%}[%D{%f/%m/%y} %D{%L:%M:%S}] %B%F{green}%n%B%F{green}|%B%F{green}%m%f %b%F{green}%~%f%b%B%F{green} $(prompt_char)%F{white} '

PR_RST="%{${reset_color}%}"
