export DT_SANDBOX_ROOT"=${HOME}/sandboxes"

# Clear the path and start over.
export PATH=~/bin:/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin

HOSTNAME=`/bin/hostname -s`

if [ `uname` == "Darwin" ] ; then
  export EMACS_DIR="/Applications/Emacs.app/Contents/MacOS"
  export GIT_EDITOR="${EMACS_DIR}/bin/emacsclient --alternate-editor=emacs"
  export EDITOR="${EMACS_DIR}/bin/emacsclient --no-wait --alternate-editor=emacs"
  export INTELLIJ="/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea"
  export PATH+=":${HOME}/software/bin"
  export PYTHONPATH="${HOME}/software/lib/python2.7/site-packages"
  export PATH=${EMACS_DIR}:${PATH}
  export DT_DIR=~/dev/devtools
  export ANDROID_HOME=/usr/local/Cellar/android-sdk/24.4.1_1
  export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
  source $(brew --prefix)/etc/bash_completion.d/bazel-complete.bash
else
  export EDITOR="/usr/bin/emacsclient --no-wait --alternate-editor=emacs"
  export PYTHONPATH=/home/kungfucraig/dev/local/lib/python3.12/dist-packages
  export PATH=${PATH}:~/bin/gradle-8.14.2/bin
  export PATH=${PATH}:~/bin/gradle-8.14.2/bin
  export PATH=${HOME}/dev/flutter/bin:${PATH}
  export PATH=${PATH}:${HOME}/.pub-cache/bin
  export DT_DIR=~/dev/devtools
  source ~/dev/devtools/shellutil/devtools.sh
fi

# Set a umask.
umask 002

# set vi mode
set -o vi

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
   if [ `/usr/bin/uname` == "Darwin" ]; then
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
# alias edit="$EDITOR"
alias sb="source ~/.bashrc"
