# A zkllvm playground compiled with Nix

I've written this Nix flake to be able to play with zkllvm without installing lots of dependencies.
It can also be used to test whether or not latest versions of all repositories build together.


## Getting started

To get a shell with the zkllvm and a prover, just do this:

```sh
nix develop
```

And wait for about 30 minutes. It will drop you to a shell where the "clang" binary would point to the one from zkllvm toolchain.

## Compiling circuits

This is how you can compile a simple circuit for a strlen function

```sh
cd example

clang -target assigner -I$ZKLLVM/include/zkllvm/c++ -I$ZKLLVM/include/zkllvm -D__ZKLLVM__ -emit-llvm -S -o circuit.ll strlen.cpp

llvm-link -S -o final_circuit.ll circuit.ll $ZKLLVM/lib/zkllvm/zkllvm-libc.ll

assigner -b final_circuit.ll -i strlen.inp -t assignment.tbl -c circuit.crct -e pallas
```

TODO: describe how to do proving
