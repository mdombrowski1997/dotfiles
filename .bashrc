# If not running interactively, don't do anything
if [[ $- != *'i'* ]]; then
    return
fi

#source aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

#make your own bash prompt line
PS1="\[\e[36m\]\h\[\e[m\]: \[$(tput bold)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;7m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
# With broken git branch
# PS1="\[\e[36m\]\h\[\e[m\] (\e[38;5;220m\]$(~/code/dotfiles/.tmux/branch $(pwd))\[\e[m\]): \[$(tput bold)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;7m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
PS2="\[$(tput bold)\]\[\033[38;5;220m\]>\[$(tput sgr0)\]\[\033[38;5;86m\]>\[$(tput sgr0)\]"

#better ls colors
#directories are lighter for better contrast
LS_COLORS=$LS_COLORS:'di=01;35:' ; export LS_COLORS

#disable this Ctrl-S, Ctrl-Q nonsense
stty -ixon
#Vi Mode
set -o vi
#but keep the glorious Alt-period combo
bind '"\e."':yank-last-arg

# append to the history file, don't overwrite it
shopt -s histappend
# don't put duplicate lines in the history.
HISTCONTROL=ignoredups
#make history unlimited
export HISTFILESIZE=
export HISTSIZE=
#set history format
export HISTTIMEFORMAT="[%F %T] "
#change the file location because certain bash sessions truncate .bash_history file upon close.
export HISTFILE=~/.bash_history_max
#force prompt to write history after every command.
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

#other important variables
export VISUAL='/usr/bin/vim'
export EDITOR='/usr/bin/vim'
export MANPAGER='/usr/bin/vim -M +MANPAGER --not-a-term -'
export SUDO_EDITOR='/usr/bin/vim'
export TERMINAL='/usr/bin/st'
#add ruby gems to path
PATH="$PATH:/home/oh/.gem/ruby/2.5.0/bin"
# Adds global yarn to path
PATH="$PATH:$(yarn global bin --offline)"
# Add paths for android-studio
export JAVA_HOME=/usr/lib/jvm/default
export ANDROID_HOME=$HOME/Android/Sdk
PATH=$PATH:$ANDROID_HOME/emulator
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/tools/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#get that good, clean, massive, tty font
if [ $TERM == 'linux' ]; then
    setfont sun12x22
fi
# Please...please get rid of the bell
set bell-style none

# For compiling SDL_Mixer
SDL_AUDIODRIVER=alsa

# export LC_ALL=C
# export LANG='en_US.UTF-8'
# export LANGUAGE='en_US:n'

