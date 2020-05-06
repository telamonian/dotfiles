# home.d

## Setup instructions for dotfiles in home.d
### Install
- Place all dotfiles (except for `.bash_profile`) in the `home.d` directory in this repo.
- Navigate to this repo in a terminal and run:

    ```
    ./initAliases.sh
    ```

    - Optionally, if you want to see exactly what links will be added without actually changing anything, you can first do a dry-run of the linking by running:

        ```
        ./initAliases.sh -d
        ```

- *Note*: for every file in `dotfile.d` whose name begins with  `.`, `initAliases.sh` creates a softlink from `${HOME}` to that file.

### Uninstall
- Navigate to this repo in a terminal and run:

    ```
    ./initAliases.sh -r
    ```

    - Optionally, if you want to see exactly what links will be removed without actually changing anything, you can first do a dry-run of the link cleanup by running:

        ```
        ./initAliases.sh -rd
        ```

