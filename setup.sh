#!/usr/bin/env bash

function installBrew() 
{
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function installCask()
{
	brew install caskroom/cask/brew-cask
}

function installBins()
{
	brew install bash-completion bash 
	brew install git git-flow tig
	brew install xctool
	brew install sl wget
}

function installCasks()
{
	brew cask install sourcetree
	brew cask install appcleaner
	brew cask install dropbox
	brew cask install istat-menus
	brew cask install iexplorer
	brew cask install sourcetree
	brew cask install virtualbox
	brew cask install vagrant
	brew cask install sublime-text3
	brew cask install spectacle
	brew cask install paw
	brew cask install fabric
}

installBrew

touch ~/.bash_profile

source ~/.bash_profile

installCask

brew tap caskroom/versions

installBins

installCasks
