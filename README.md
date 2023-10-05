# A zkllvm playground compiled with Nix

I've written this Nix flake to be able to play with zkllvm without installing lots of dependencies.
It can also be used to test whether or not latest versions of all repositories build together.


## Getting started

To build zkllvm and related utilities, just do:

```sh
nix build
```

And wait. After 30 minutes or so, you should have everything built correctly in the `result/` directory.
