#
# ~/.bashrc
#
export EDITOR=nvim
export BROWSER=firefox
export TERM=alacritty

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

tmpd() {
        cd "$(mktemp -d)" || exit
}

clip() {
        xclip -selection clipboard
}

shopt -s checkwinsize
shopt -s cdspell
shopt -s dirspell
shopt -s autocd
set -o vi

# bash history configuration
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# tmux attach or create named session
alias tmuxa='tmux new-session -A -s'

# Assetto Corsa server start
alias corsaserver='wine /home/skrcka/Games/SteamLibrary/steamapps/common/assettocorsa/server/acServer.exe'

# copy current dir
alias cwd='pwd | tr -d "\r\n" | xclip -selection clipboard'

# zruseni lp
alias lp='echo nope, lp disabled in .bashrc'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# color ls
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

# custom scripts export
export PATH=$PATH:$HOME/.local/bin
export PATH="$PATH:/home/skrcka/.dotnet/tools"

# plantuml
export PLANTUML_JAR=/home/skrcka/.local/opt/plantuml/plantuml.jar

# lang export (latex fix)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# VNC
vnc() (
  ssh -L 5900:localhost:5900 "$1" '/usr/bin/x11vnc -localhost -display :0  -rfbauth ~/.vnc/passwd' &
  pid=$!
  host=$1

  clean() {
    kill $pid
    ssh "$host" killall x11vnc
  }
  trap clean EXIT

  sleep 1
  vncviewer localhost
)
