#!/bin/bash

# ~/.dotfiles/install/brew-updates.sh -- update brew, install it if necessary
# http://brew.sh, search for brew formulae at http://braumeister.org
#
# also sourced by `allosxupdates.sh`

# Can be executed remotely on a new machine via:

# $ curl -L https://raw.githubusercontent.com/ChristopherA/dotfiles/master/install/brew-updates.sh | bash

# Script Debugger

#SCRIPT_DEBUG=true
SCRIPT_DEBUG=false

# kill on error
set -e

brew_updates() {

# Check for Homebrew
if test ! $(which brew); then
  if $SCRIPT_DEBUG; then echo "...Installing Homebrew."; fi

  if $SCRIPT_DEBUG
    then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /dev/null
  fi

  # Check Homebrew installation

  if $SCRIPT_DEBUG; then echo "...Checking installation."; fi

  if $SCRIPT_DEBUG
    then
      brew doctor
    else
      brew doctor > /dev/null
  fi

  if $SCRIPT_DEBUG; then echo "...Homebrew installed."; fi

fi

# Update the latest version of Homebrew

if $SCRIPT_DEBUG; then echo "...Updating Homebrew."; fi

if $SCRIPT_DEBUG
  then
    brew update
  else
    brew update > /dev/null
fi

# Upgrade any outdated, unpinned brews

if $SCRIPT_DEBUG; then echo "...Upgrade any outdated, unpinned brews."; fi

if $SCRIPT_DEBUG
  then
    brew upgrade
  else
    brew upgrade > /dev/null
fi

# Symlink any .app-style brews applications locally to ~/Applications

if $SCRIPT_DEBUG; then echo "...Symlink any .app-style brews."; fi

if $SCRIPT_DEBUG
  then
    brew linkapps --local
  else
    brew linkapps --local > /dev/null
fi


# Cleanup old Homebrew formula

if $SCRIPT_DEBUG; then echo "...Cleanup old brew formula."; fi

if $SCRIPT_DEBUG
  then
    brew cleanup
  else
    brew cleanup > /dev/null
fi

# Prune dead Homebrew symlinks

if $SCRIPT_DEBUG; then echo "...Prune dead symlinks."; fi

if $SCRIPT_DEBUG
  then
    brew prune
  else
    brew prune > /dev/null
fi

if $SCRIPT_DEBUG; then echo "...Homebrew updated."; fi


} # end function load_bashrc_files()

brew_updates
unset brew_updates
