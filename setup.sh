#!/bin/bash
DOTFILE_ROOT=~/workspace/dotfiles

check_ssh_agent() {
  if env | grep --quiet SSH_AUTH_SOCK ; then
    echo SSH agent is running
  else
    echo SSH agent is _not running. I refuse to continue
    exit 1
  fi
}

config_ctags() {
  if [ ! -e ~/.ctags ]; then
    echo "No .ctags"
    cp ~/workspace/dotfiles/ctags/.ctags ~/.ctags
  else
    echo ".ctags exists. Not copying"
  fi
}

config_vim() {
  if [ ! -d  ~/.vim/bundle ]; then
    echo No bundle directory
  else
    echo Bundle directory exists
  fi

  if [ ! -d ~/.vim/autoload ]; then
    echo No autoload directory
  else
    echo Autoload directory exists
  fi

  if [ ! -e  ~/.vimrc ]; then
    echo "There's no vimrc"
  else
    echo "vimrc exists"
  fi
}

config_git() {
  if [ ! -e ~/.gitconfig ]; then
    echo "No .gitconfig"
    #git config --global 
    cp ~/workspace/dotfiles/git/.gitconfig ~/.gitconfig
    git config --global user.name $NAME
    git config --global user.email $EMAIL
  else
    echo ".gitconfig exists, not copying"
  fi

  if [ ! -d ~/.git_template ]; then
    echo No template directory
    cp -r ~/workspace/dotfiles/git/.git_template ~
  else
    echo Hooks directory exists
  fi
}

check_args()
{
  if test $NAME
  then
    echo NAME = $NAME
  else
    echo  "NAME not defined"
    exit
  fi 

  if test $EMAIL
  then
    echo EMAIL = $EMAIL
  else
    echo  "EMAIL not defined"
    exit
  fi
}

while [ $# -ne 0 ] ; do
  case "$1" in
  test)
    echo "testing"
    ;;
  -name)
    NAME=$2
    shift
    ;;
  -email)
    EMAIL=$2
    shift
    ;;
  *)
    echo "unknown argument: $1"
    usage
    exit 1
  esac
  shift
done

echo 
check_args
echo
check_ssh_agent
config_vim
config_ctags
config_git
