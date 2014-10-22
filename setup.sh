#!/usr/bin/env bash

function installBrew() 
{
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
}

function installCask()
{
	brew install caskroom/cask/brew-cask
}

function installBins()
{
	brew install bash-completion bash 
	brew install git git-flow tig
	brew install sqlite xctool
	brew install youtube-dl
	brew install sl wget doxygen
	brew install android-sdk android-ndk
	brew install x264 ffmpeg
}

function installCasks()
{
	brew cask install gitx-rowanj
	brew cask install appcleaner
	brew cask install dropbox
	brew cask install istat-menus
	brew cask install ifunbox
	brew cask install java
	brew cask install android-studio
	brew cask install mplayerx
	brew cask install sourcetree
	brew cask install virtualbox
	brew cask install unrarx
	brew cask install vagrant
	brew cask install transmission
	brew cask install plug
	brew cask install sublime-text
	brew cask install spectacle
}

installBrew

source ~/.bash_profile

installCask

installBins

installCasks