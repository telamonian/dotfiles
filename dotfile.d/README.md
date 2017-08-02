# dotfile.d

## Setup instructions for dotfiles in dotfile.d
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