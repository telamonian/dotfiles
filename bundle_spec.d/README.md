# Bundle Specs/Manifests
## Lists of packages managed by various package managers such as homebrew, TeX, python-pip, etc. 
The eventual goal is to ensure that all bundles specs are setup for two-way sync with the current live system install (ie the spec can be automatically generated from the live install, and an automatic installation can be carried out from the spec), but this is not possible for certain spec files (eg `tex_manifest.tex`) currently.

## live install &rlarr; spec file syncing instructions
### live install &rarr; spec file

- TeX
    ```
    tlmgr list --only-installed > <spec-file.tex>
    ```

- homebrew
    ```
    tlmgr list --only-installed > <spec-file.tex>
    ```
    
- python-pip
    ```
    tlmgr list --only-installed > <spec-file.tex>
    ```
    
### spec file &rarr; live install

- homebrew
    ```
    tlmgr list --only-installed > <spec-file.tex>
    ```
    
- python-pip
    ```
    tlmgr list --only-installed > <spec-file.tex>
    ```