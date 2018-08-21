# Bundle Specs/Manifests

The purpose of this module is to allow for automatic backup and restoration of the state of various package managers. It contains one set of `backup` scripts for creating manifests based on the currently installed packages, and another set of `restore` scripts for installing all of the packages listed in a manifesto.

## Backup Scripts

- TeX Live Manager
    ```
    ./backup_tex.sh
    ```
- homebrew
    ```
    ./backup_homebrew.sh
    ```
- python-pip (handles both Python 2 and 3)
    ```
    ./backup_python.sh
    ```

## Restore Scripts

- homebrew
    ```
    ./restore_homebrew.sh
    ```
- python-pip (handles both Python 2 and 3)
    ```
    ./restore_python.sh
    ```
    
## Notes
### Detailed Manual Live Install &rlarr; Spec File Syncing Instructions
#### live install &rarr; spec file

- TeX
    ```
    tlmgr list --only-installed > tex_manifest.tex
    ```

- homebrew (see https://github.com/Homebrew/homebrew-bundle)
    ```
    brew bundle dump
    ```
    - The `--force` option will allow an existing Brewfile to be overwritten as well.
    
- python-pip (see https://pip.pypa.io/en/stable/reference/pip_freeze/)
    ```
    pip freeze > "${MANIFESTS}/py_manifest.txt"
    ```
    
#### spec file &rarr; live install

- homebrew (see https://github.com/Homebrew/homebrew-bundle)
    ```
    brew bundle
    ```
    
- python-pip (see https://pip.pypa.io/en/stable/reference/pip_freeze/)
    ```
    pip install -r "${MANIFESTS}/py_manifest.txt"
    ```