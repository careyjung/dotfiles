# Carey's Dotfiles - MacOS Setup and Configuration

## Overview

This repo is a fork of and owes largely to Mathias Bynen's rich [dotfiles](https://github.com/mathiasbynens/dotfiles) repo. I have left the content and organization of his dotfiles largely unchanged, but focused on making the installation/bootstrap scripting cleaner and dependency-free. To this end, I also pulled in some ideas from Peter Bosse's [mac-setup](https://github.com/ptb/mac-setup) repo, which is geared towards completely unattended MacOS installs.

My resulting bootstrapping script combo, `kickstart` plus `setup`, should run on a pristine MacOS High Sierra install without any additional prep work. Just do a clean install, open a Terminal window, and run (from any directory)

The `kickstart` script will install Homebrew, git, create an SSH key, if needed, wait for you to add it to your github account, clone this repo to a `dotfiles` subdirectory, cd to it, and then kick off the `setup` script to complete the install.

I designed the setup script to be flexible and modular. You can easily modify the list of dot-files and dot-dirs to be installed and add setup functions for additional apps or subsystems by modifying the shell arrays defined at the top and adding your own function calls. You can also run parts of `setup` manually and interactively, so you can test new setup functions easily without having to re-play the whole show. For example, `setup -i dock finder` will run just the Dock and Finder setup functions alone, skipping everything else.

## Installation

After completing a fresh MacOS install, login (as an Admin user), open a Terminal window, and run:

```
curl -fsSL https://raw.githubusercontent.com/careyjung/dotfiles/master/kickstart|sh
```
