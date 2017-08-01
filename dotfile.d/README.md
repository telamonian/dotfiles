# dotfile.d

### Setup instructions for dotfiles in dotfile.d
- Place all dotfiles (except for `.bash_profile`) in the `dotfile.d` directory in this repo.
- Navigate to the top level of this repo in a terminal and run:
    
    ```
    ./initAliases.sh
    ```
    
    - Note: for every file in `dotfile.d` whose name begins with  `.`, `initAliases.sh` creates a softlink from `${HOME}` to that file.