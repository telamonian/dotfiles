#!/usr/bin/env bash
formula_full_name=$1

brew install --only-dependencies --build-bottle --verbose "${formula_full_name}"
brew install --build-bottle --verbose "${formula_full_name}"
