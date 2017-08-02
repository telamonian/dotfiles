# Tel's Dotfile Repository

## Quick Start Guide
- Two steps required for use:
    - Add these lines to the top of your `~/.bash_profile`:
        ```
        DOTFILES=<path-to-your-dotfile-repo>
        
        for bashsrc in ${DOTFILES}/bash_profile.d/.bash_*; do
            source $bashsrc
        done
        ```
    - Run the `initAliases.sh` script that's located at the root of this repository.

## List of Dotfiles

- Current dotfiles
    - **bash_profile.d**
        - A modularized version of .bash_profile, with various functionalities split into various files.
    - **.bashrc**
        - Bare bones, with just a couple of lines for ensuring that .bash_hist doesn't get accidentally truncated when non-login shells are created.
    - **.pythonstartup.py**
        - For automatically including a couple of useful packages every time python is started (eg numpy aliased to np).
    - **.tmux.conf**
        - Gives a nice status line.
        - Ensures that all of the vim copy/paste stuff (described below) works correctly for vim instances run in tmux windows.
    - **.vim** *and* **.vimrc**
        - Sets various personal preferences, such as reopening files at the line on which they were closed, etc.
        - Ensures that bash is recognized as a specific filetype, instead of the default vim behavior of combining sh, bash, and korn shell into a single filetype.
        - Ensures that copying/pasting using the normal system clipboard/shortcuts (cmd-c/cmd-v) works as expected without needing to enter and exit paste mode.

## Features

- Current features
    - Init scripts for automatically managing dotfiles
        - dotfiles can be added to management by simply placing them in dotfiles.d
    - Fancy/complex .bash_profile settings, split up into modules
        - Includes a bunch of useful bash functions for navigating both the filesystem and a user's bash history
        - Automatically backs up .bash_hist at start of every terminal session
            - .bash_hist is automatically restored from backup in case of truncation

- Planned features
    - Homebrew integration
    - Vagrant integration

## Full Instructions

### .bash_profile setup
#### Install
- Create `~/.bash_profile` if it doesn't exist.
- Manually add the following lines to the top of `~/.bash_profile`:
    
    ```
    DOTFILES=<path-to-your-dotfile-repo>
    
    for bashsrc in ${DOTFILES}/bash_profile.d/.bash_*; do
        source $bashsrc
    done
    ```
    
- *Note*: by design, nothing in this repo will automatically alter your existing `~/.bash*` files
    - *exception: `~/.bash_history` has some automatic restoration behavior set in bash_profile.d/.bash_hist_setup*

#### Uninstall
- Just manually remove the above lines from your `~/.bash_profile`

### Setup for other dotfiles
#### Install
- Place all dotfiles (except for `.bash_profile`) in the `dotfile.d` directory in this repo. The names of all dotfiles must actually begin with the `.` character.
- Navigate to this repo in a terminal and run:
    
    ```
    ./initAliases.sh
    ```
    
    - Optionally, if you want to see exactly what links will be added without actually changing anything, you can first do a dry-run of the linking by running:
    
        ```
        ./initAliases.sh -d
        ```
    
- *Note*: for every file in `dotfile.d` whose name begins with  `.`, `initAliases.sh` creates a softlink from `${HOME}` to that file.

#### Uninstall
- Navigate to this repo in a terminal and run:
    
    ```
    ./initAliases.sh -r
    ```
    
    - Optionally, if you want to see exactly what links will be removed without actually changing anything, you can first do a dry-run of the link cleanup by running:
        
        ```
        ./initAliases.sh -rd
        ```