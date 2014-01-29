# This is a bash extension file that I can share with others.
# It does not have anything in it that preclude it from being used
# by others.

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

# Function to find a remove files.
# It takes one argument, then 
function findandremove
{
    find . -name $1 -exec rm -f {} \;
}

# A function to find files by name
function hunt
{
    find . -name $1 
}

function command-search
{
   oldIFS=${IFS}
   IFS=":"

   for p in ${PATH}
   do
      ls $p | grep $1
   done

   export IFS=${oldIFS}
}

# Set a common prompt.
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
export EDITOR="/usr/bin/emacsclient --no-wait --alternate-editor=emacs"
export CVSEDITOR="/usr/bin/emacsclient --alternate-editor=emacs"
export SVN_EDITOR="/usr/bin/emacsclient --alternate-editor=emacs"
#export EDITOR="gvim --remote"

alias edit="$EDITOR"
alias medit="managed-edit"

# Some options I like for my xterms in Cygwin
# The Windows way to do this is:
# C:\cygwin\bin\run.exe -p /usr/X11R6/bin xterm -display 127.0.0.1:0.0 -ls +tb -j -sb -si -sk -rightbar
alias xt="xterm -display 127.0.0.1:0.0 -ls +tb -j -sb -si -sk -rightbar &"

function ccd
{
   x=`me -d $@`
   if [ -n "$x" ]
   then
     cd $x
   fi
}

function setdisplay
{
  export DISPLAY=$1:0.0
}


##############################################
# GO
#
# Inspired by some Windows Power Shell code
# from Peter Provost (peterprovost.org)
#
# Here are some examples entries:
# work:${WORK_DIR}
# source:${SOURCE_DIR}
# dev:/c/dev
# object:${USER_OBJECT_DIR}
# debug:${USER_OBJECT_DIR}/debug
###############################################
export GO_FILE=~/.go_locations
function go
{
   if [ -z "$GO_FILE" ]
   then
      echo "The variable GO_FILE is not set."
      return
   fi

   if [ ! -e "$GO_FILE" ]
   then
      echo "The 'go file': '$GO_FILE' does not exist."
      return
   fi

   dest=""
   oldIFS=${IFS}
   IFS=$'\n'
   for entry in `cat ${GO_FILE}`
   do
      if [ "$1" = ${entry%%:*} ]
      then
         #echo $entry
         dest=${entry##*:}
         break
      fi
   done

   if [ -n "$dest" ]
   then
      # Expand variables in the go file. 
      #echo $dest
		# make sure there are no \r characters in the .go_locations file.
      cd `eval echo $dest`
   else
      echo "Invalid location, valid locations are:"
      cat $GO_FILE
   fi
   export IFS=${oldIFS}
}
alias d='go'
