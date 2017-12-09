# bash_profile.d

## .bash_profile setup instructions
#### Install
- Create `~/.bash_profile` if it doesn't exist.
- Manually add the following lines to the top of `~/.bash_profile`:
    
    ```
    DOT_REPO=<path-to-your-dotfile-repo>
    
    # import the .bash_* files from dotfiles
    for bashsrc in $(${DOT_REPO}/src/bashProfilePaths.sh); do
        source $bashsrc
    done
    ```

- *Note*: by design, nothing in this repo will automatically alter your existing `~/.bash*` files
    - *exception: `~/.bash_history` has some automatic restoration behavior set in bash_profile.d/.bash_hist_setup*

#### Uninstall
- Just manually remove the above lines from your `~/.bash_profile`
