#!/usr/bin/env bash
set -e

formula_full_name=homebrew/science/pymol

# ensure that the needed taps are tapped
brew tap homebrew/science

# checkout original formula
echo "Checkout out old ${formula_full_name} formula"
cd $(brew --repository homebrew/science)
set +e
git remote add telamonian https://github.com/telamonian/homebrew-science.git
set -e
git fetch
git checkout origin/master -- pymol.rb

# build all dependencies for old formula
echo "Building dependencies for old ${formula_full_name} formula"
brew install --only-dependencies --build-bottle --verbose --debug "${formula_full_name}"

# checkout new formula
echo "Checkout out new ${formula_full_name} formula"
#git checkout telamonian/ -- pymol.rb
cp /vagrant/pymol.rb $(brew --repository homebrew/science)

# build new formula
echo "Building new ${formula_full_name} formula"
brew install --build-bottle --verbose --debug "${formula_full_name}"
brew install --build-bottle --verbose --debug "${formula_full_name}"
