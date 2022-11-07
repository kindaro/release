#!/bin/sh -e

echo 'Writing `release.yml`…'
name_of_program="$(basename "$(pwd)")" envsubst '$name_of_program' < ./release.yml > .github/workflows/release.yml
if ! git diff --quiet '.github/workflows/release.yml'
then
    git reset
    git add '.github/workflows/release.yml'
    git commit --message 'Update `release.yml`.'
fi

echo 'Tagging and pushing…'
if ! { git diff --quiet && git diff --cached --quiet; }
then
   echo 'You have uncommitted changes. I do not think you want to release this yet.'
   echo 'Please commit or stash your changes!'
    exit 1
else
    git tag "v$(grep --ignore-case '^version' ./*.cabal | grep --only-matching '[^ \t]*$')"
    git push --tags
fi
