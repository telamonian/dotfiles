# Tel's Dotfile Repository

## Quick Start Guide
Both install and uninstall only require two easy steps:

### Install
- Navigate to the root of this repo and run `src/initAliases.sh`.
- In your `.bash_profile` file, add the following single line:
    - `source "${HOME}/.bash_dotfiles_activate"`
### Uninstall
- Remove the `source "${HOME}/.bash_dotfiles_activate"` from your `.bash_profile`.
- Navigate to the root of this repo and run `src/initAliases.sh -r`.

## Features

- Current features
    - Init scripts for automatically managing dotfiles
        - dotfiles can be added to management by simply placing them in `home.d`
    - Fancy/complex `.bash_profile` settings, split up into modules
        - Includes a bunch of useful bash functions for navigating both the filesystem and a user's bash history
        - Automatically backs up `.bash_hist` at start of every terminal session
            - `.bash_hist` is automatically restored from backup in case of truncation
    - Automated backup/restore of packages installed by various package managers
        - TeX Live Manager (backup only)
        - Homebrew
        - Python-Pip
    - Vagrant integration
        - Scripts have been added to `virtual_machine.d` for initializing and running VMs.

- Planned features
    - Automatic encryption/decryption of private/sensitive files

## List of Modules in this Dotfile Repo
This dotfile repo is organized as a set of directories, each of which implements its own separate module:

- **bash_profile.d**
    - A modularized version of .bash_profile, with various functionalities split into various files.
- **bundle.d**
    - (partially implemented) A set of scripts and manifests that allow for the recording and restoration of the state of various package managers.
- **home.d**
    - Where the "actual" dotfiles go:
        - **.bashrc**
            - Bare bones, with just a couple of lines for ensuring that .bash_hist doesn't get accidentally truncated when non-login shells are created.
        - **.byebugrc**
            - For the byebug ruby debugging gem. Prevents writing of debugger history, preventing crashes due to permissions issues.
        - **.pythonstartup.py**
            - For automatically including a couple of useful packages every time python is started (eg numpy aliased to np).
        - **.tmux.conf**
            - Gives a nice status line.
            - Ensures that all of the vim copy/paste stuff (described below) works correctly for vim instances run in tmux windows.
        - **.vim** *and* **.vimrc**
            - Sets various personal preferences, such as reopening files at the line on which they were closed, etc.
            - Ensures that bash is recognized as a specific filetype, instead of the default vim behavior of combining sh, bash, and korn shell into a single filetype.
            - Ensures that copying/pasting using the normal system clipboard/shortcuts (cmd-c/cmd-v) works as expected without needing to enter and exit paste mode.
    - When `initAliases.sh` is run, each file contained in `home.d` is symlinked to the user's actual home dir. The directory structure present in `home.d` is preserved.
- **notes**
    - Miscellaneous notes.
- **setting.d**
    - Contins settings files for various apps.
- **src**
    - Scripts that implement the inner workings of this dotfile repo.
- **virtual_machine.d**
    - Contains various scripts (in particular, vagrant) for initializing and running VMs.
