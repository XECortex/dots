
## Options section
setopt autocd
setopt correct
setopt extendedglob
setopt nomatch
setopt rcexpandparam
setopt numericglobsort
setopt nobeep
setopt appendhistory
setopt histignorealldups

# Case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Automatically find new executables in path
zstyle ':completion:*' rehash true
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

HISTFILE=~/.zhistory
HISTSIZE=2048
SAVEHIST=1024

export EDITOR=/usr/bin/nano
export VISUAL=/usr/bin/nano

# Don't consider certain characters part of the word
WORDCHARS=${WORDCHARS/\/}

alias ls='ls -a --color'
alias cp='cp -i'
alias df='df -h'
alias free='free -m'
alias gitu='git add . && git commit && git push'
alias bashtop='bpytop'
alias clock='tty-clock -s -c -C 6 -f "%A, %d.%m.%Y" -d 100ms'
alias fetch='neofetch --ascii_distro Artix_small'
alias py='python'

# Set terminal title
echo -en "\033]0;Terminal - $USER@$(hostname)\a"

## Promt style
PS1="%B%F{6}%n%f%F{8}%b@%f%F{6}%m %f%F{10}%B%1~ %f%F{7}»%f%F{15}%b "
RPS1="%f%F{7}[%f%F{8}%y %f%F{7}$(date +"%k:%M:%S")] %f%F{8}[%?]"

# Greeting message
TIME=$(date "+%H")
greeting_message="Good day"

if [ $TIME -gt 21 ]; then
	greeting_message="Good night"
elif [ $TIME -gt 18 ]; then
	greeting_message="Good evening"
elif [ $TIME -gt 15 ]; then
	greeting_message="Good afternoon"
elif [ $TIME -gt "11" ]; then
	greeting_message="Good day"
elif [ $TIME -gt "6" ]; then
	greeting_message="Good morning"
else [ $TIME -ge 0 ]
	greeting_message="Good night"
fi

echo
echo "\e[97m$greeting_message, $(echo $(echo $(getent passwd $USER) | cut -d ':' -f 5) | cut -d ',' -f 1)!"
echo "\e[37m$(date +"%d.%m.%Y, %k:%M:%S") \e[90m$(uname -r)"
echo

## Keybindings section
bindkey -e
bindkey '^[[H' beginning-of-line
bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char
bindkey '^[[F' end-of-line
bindkey '^[[C'  forward-char
bindkey '^[[D'  backward-char
bindkey '^[[5~' history-beginning-search-backward
bindkey '^[[6~' history-beginning-search-forward
bindkey '^[[A'  up-line-or-history
bindkey '^[[B'  down-line-or-history
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word
bindkey '^Z' undo

## Plugins section
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# From powerlevel10ks README.md
colors() {
	for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i} ${(l:3::0:)i}%f  " ${${(M)$((i%6)):#3}:+$'\n'}; done
}
