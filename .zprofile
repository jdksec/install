rm(){mv $1 ~/.trash/$1-$(date +%d%m%y-%H%M%S)}
s(){source ~/.zshrc}
random(){perl -MList::Util -e 'print List::Util::shuffle <>'}
mkdirdate(){mkdir $(date +%d-%m-%y_%H-%M-%S)}
+tmuxlog(){tmux capture-pane -pS -1000000 | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ~/terminallogs.txt}
