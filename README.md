# `release`

Generate a GitHub workflow that automatically makes releases for your Haskell executable program. 

This is mostly thanks to  [Veronika's hard work][1]. I _(@kindaro)_ made it up a little since some stuff bitrotted over time. All mistakes are mine.

[1]: https://vrom911.github.io/blog/github-actions-releases

## how does it work

`./release.yml` is a template for `envsubst`, shipped with `gettext`, which is a standard internationalization package by GNU. It requires that the environment variable `name_of_program` be set to the name of the program you wish to be releasing. Then `envsubst` will work as a filter, instantiating the template into a ready-made workflow script.

Here is one example of how you can instantiate the template to your project:

```
% name_of_program=`basename $(pwd)` envsubst '$name_of_program' < ./release.yml > .github/workflows/release.yml
```

In order for the workflow to run, you need to add a tag of form `v.*` to a commit. Normally, you would tag the current commit with the version of your Cabal package, like so:

```
% git tag "v$(grep --ignore-case '^version' *.cabal | grep --only-matching '[^ \t]*$')"
```

Then you need to push tags to GitHub:

```
% git push --tags
```

Now you should see the workflow running on GitHub. After some time, you will see a draft release having been created, with built executables attached to it.

### a hopefully helpful script

There is a shell script called `release.sh` that will regenerate `haskell-ci` and `release` workflows, then tag and push your stuff.

## features

* Will build executables for Linux, MacOS and Windows out of the box.
  - But only if `haskell-ci` succeeds.
