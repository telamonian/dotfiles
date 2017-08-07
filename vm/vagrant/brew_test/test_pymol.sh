#!/usr/bin/env bash
formula_full_name=homebrew/science/pymol

brew tap homebrew/science

# checkout original formula
cd $(brew --repository homebrew/science)
git remote add telamonian https://github.com/telamonian/homebrew-science.git
git fetch
git checkout origin/master -- pymol.rb

# build all dependencies for old formula
brew install --only-dependencies --build-bottle --verbose --debug "${formula_full_name}"

# checkout new formula
#git checkout telamonian/ -- pymol.rb
cp /vagrant/pymol.rb $(brew --repository homebrew/science)

# build new formula
brew install --build-bottle --verbose --debu "${formula_full_name}"
