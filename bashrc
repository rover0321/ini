# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# uname on ubuntu is Linux
# uname on mac is Darwin
osname=`uname`

if [ $osname == "Darwin" ]; then
    alias dir='ls'
    export CLICOLOR=1 # enable color style
    export TERM=xterm-color
else
    alias dir='dir'
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto'

    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

ips=(`ifconfig | grep 'inet addr' | awk '{print $2}' | awk -F: '{print $2}' | sort`)
len=${#ips[@]}
IP=
for ip in ${ips[@]}; do
    if [ ! $ip = 127.0.0.1 ]; then
        IP="$ip "
    fi
done

if [ ! $osname == "Darwin" ]; then
    if [ `whoami` = root ]; then
        export PS1="\[\e[31m\][${IP}\u@\H]\[\e[m\]\[\e[33m\]:\w# \[\e[m\]"
    else
        export PS1="\[\e[31m\][${IP}\u@\H]\[\e[m\]\[\e[33m\]:\w\$ \[\e[m\]"
    fi
else
    if [ `whoami` = root ]; then
        export PS1="\[\e[31m\][\u@\H]\[\e[m\]\[\e[33m\]:\w# \[\e[m\]"
    else
        export PS1="\[\e[31m\][\u@\H]\[\e[m\]\[\e[33m\]:\w\$ \[\e[m\]"
    fi
fi

################################################################################
# DIR CMD
################################################################################
# alias for reading all kind of readme file
alias r='if [ -e README ]; then more README; elif [ -e readme ]; then more readme; elif [ -e readme.txt ]; then more readme.txt; elif [ -e README.TXT ]; then more README.TXT; fi;'

if [ $osname == "Darwin" ]; then
    alias c='pwd && echo ------------------------------------------------------------  && ls -lh'
    alias xxx='sudo shutdown -h +1'
    alias du='du -m'
    alias XXX='sudo shutdown -h now'
else
    alias c='pwd && echo ------------------------------------------------------------  && ls -lh --color=auto --group-directories-first'
    alias XXX='sudo shutdown -P now'
    alias xxx='gnome-screensaver-command -l'
    alias du='du -BM'
fi

alias c.='cd .. && c'
alias c..='cd - && c'
alias e='clear'
alias t='cd ./tmp'
alias wks='cd ~/wks'
alias ini='cd ~/ini'
alias ins='cd ~/ins'
alias bin='cd ~/bin'

if [ $osname == "Darwin" ]; then
    alias udb='sudo /usr/libexec/locate.updatedb'
    alias ls='ls'
else
    alias udb='sudo updatedb'
    alias ls="ls -l --time-style='+%Y-%m-%d %H:%M' -h --color=auto"
fi

alias la='ls -lah'
alias lr='ls -ltrh'
alias cls='clear'
alias vit='vi -t'
alias his='history'
alias fdn='find . -name'
alias where='find ./ | grep --color=auto'

################################################################################
# Maven CMD
################################################################################
alias mpi='mvn package install -Dmaven.test.skip=true'
alias mci='mvn clean install -Dmaven.test.skip=true'
alias mcl='mvn clean'

################################################################################
# GIT CMD
################################################################################
alias gad='git add'
alias gbr='git branch'
alias gcm='git commit'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gdf='git diff'
alias gdt='git difftool'
alias ghp='git help'
alias glg='git log --stat'
alias gmg='git merge'
alias gmv='git mv'
alias gps='git push'
alias gpl='git pull'
alias grb='git rebase'
alias grm='git rm'
alias grs='git reset'
alias gsh='git show'
alias gst='git status'
alias gtg='git tag'
alias gwc='git whatchanged'
alias gfp='git format-patch'

################################################################################
# SYSTEM CMD
################################################################################
alias tx='tar xvf'
alias zx='tar zxvf'
alias jx='tar jxvf'
alias uz='unzip'
alias cfg='./configure'
alias cp='cp -r'
alias rm='rm -fr'
alias me='vi ~/.bashrc'
alias use='. ~/.bashrc'
alias loc='locate'
alias evc='evince'
alias o='open'
alias zl='zeal'

# set time stamp for tag operation
alias sts='timestamp=`date +%Y%m%d%H%M%S` && echo timestamp=$timestamp'
alias smi='sudo make install'
alias sai='sudo apt-get install'
alias sas='sudo apt-cache search'
alias sar='sudo apt-get remove'
alias saa='sudo apt-get autoremove'
alias sau='sudo apt-get update'
alias sauu='sudo apt-get update && sudo apt-get upgrade'
alias X='exit'
alias E='exit'
alias showip="ifconfig | grep -i mask | grep -i inet"
alias chdirmod755='find . | while read line; do if [ -d "$line" ]; then chmod 755 "$line"; echo "chmod 755 $line"; fi; done;'


###############################################################################
# ANDROID CMD
###############################################################################
alias x="cd \`cat ~/.alias.x\` && c"
alias pkg='x && cd packages/apps && c'
alias app='x && cd out/target/product/generic/system/app && c'
alias sbe='x && . build/envsetup.sh && prebuilts/misc/linux-x86/ccache/ccache -M 50G'
alias fwk='x && cd frameworks/base && c'
alias s='adb shell'
alias aks='adb kill-server && adb start-server'
alias alc='adb logcat'

###############################################################################
# GOOGLE AGENT
###############################################################################
# https://www.googlesource.com/new-password
alias gas='~/ins/gae/google.agent/local/proxy.sh'
alias gar='~/ins/gae/google.agent/local/proxy.sh restart'
alias gaS='~/ins/gae/google.agent/local/proxy.sh stop'


###############################################################################
# TOMCAT
###############################################################################
alias tmc='cd && cd ins/tmc && c'
alias web='tmc && cd webapps && c'
alias psj='ps aux | grep java'
alias pst='ps aux | grep tomcat'
alias log='tail -f ~/ins/tmc/logs/catalina.out'
alias taf='tail -f'
alias iml='find . -name *.iml -o -name .idea -o -name target | while read i; do echo "delete $i"; rm $i; done; find . -name *.iml -o -name .idea -o -name target | while read i; do echo "delete $i"; rm $i; done;'

###############################################################################
# EXTRAL BASH CONFIG
###############################################################################
# ~/.bash is used for extra ENV
# pls hold this line at the end of this file
if [ -f ~/.bash ]; then
	source ~/.bash
fi
