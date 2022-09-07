# `release`

Generate a GitHub workflow that automatically makes releases for your Haskell executable program. 

## how does it work

`./release.yml` is a template for `envsubst`, shipped with `gettext`, which is a standard internationalization package by GNU. It requires that the environment variable `name_of_program` be set to the name of the program you wish to be releasing.

Here is one example of how you can instantiate this template to your project:

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
