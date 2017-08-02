# bash_profile.d

## .bash_profile setup instructions
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