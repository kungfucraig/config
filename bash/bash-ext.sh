# This is a bash extension file that I can share with others.
# It does not have anything in it that preclude it from being used
# by others.

HOSTNAME=`hostname -s`
if [ "$HOSTNAME" == "rothbard" ]; then
  export EDITOR="/usr/local/bin/emacsclient --no-wait --alternate-editor=emacs"
  alias povray="~/dev/raytrace/PovrayCommandLineMac/Povray37UnofficialMacCmd"
else
  export EDITOR="/usr/bin/emacsclient --no-wait --alternate-editor=emacs"
fi

# Clear the path and start over.
export PATH=""

# Set a umask.
umask 002

if [ -z $OS ]
then
   export OS=`/usr/bin/uname`
fi

# set vi mode
set -o vi

# Setup the PATH to include a person's personal bin directory
# and the sbin directories. It's nice to have these commands.
export PATH=~/bin:/bin/:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin

# Set the PAGER to be less
export PAGER="less"

# Change the window title of X terminals
case $TERM in
	xterm*|rxvt|Eterm|eterm)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac


# Setup alias for ls and deal with ls colors.
# Only do this if the terminal is not dumb.
if [ $TERM == "dumb" ]
then
   alias ls="ls -F"
   alias ll="ls -alF"
   alias li="ls -F"
else
   if [ "$OS" == "Darwin" ]; then
     alias ls="ls -FG"
   else
     alias ls="ls --color=auto -F"
     alias ll="ls --color -alF"
     alias li="ls --color=auto -F"
   fi
fi

# Setup remove to be less destructive.
alias rm='rm -i'

if [ -n "$PS1" ]
then
   # Same prompt with color or not?
   if [ $TERM == "dumb" ]
   then
     export PS1="[\u@\h][\w]\n$ "
   else
     export PS1="\[\033[01;32m\][\u@\h]\[\033[01;34m\][\w]\n\$ \[\033[00m\]"
   fi
fi

# Set up environment for editing files
#export BROWSER="/usr/bin/emacsclient --no-wait --alternate-editor=emacs"
alias edit="$EDITOR"
alias sb="source ~/.bashrc"
