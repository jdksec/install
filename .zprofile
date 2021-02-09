rm(){mv $1 ~/.trash/$1-$(date +%d%m%y-%H%M%S)}
s(){source ~/.zshrc}
Ip(){curl ifconfig.co}
random(){perl -MList::Util -e 'print List::Util::shuffle <>'}
mkdirdate(){mkdir $(date +%d-%m-%y_%H-%M-%S)}
