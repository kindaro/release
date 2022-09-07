# `release`

Generate a GitHub workflow that automatically makes releases for your Haskell executable program. 

## how does it work

`./release.yml` is a template for `envsubst`, shipped with `gettext`, which is a standard internationalization package by GNU. It requires that the environment variable `name_of_program` be set to the name of the program you wish to be releasing.

Here is one example of how you can instantiate this template to your project:

```
% name_of_program=`basename $(pwd)` envsubst '$name_of_program' < ./release.yml > .github/workflows/release.yml
```
