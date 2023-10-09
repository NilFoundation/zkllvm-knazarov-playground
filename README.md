# A zkllvm playground compiled with Nix

I've written this Nix flake to be able to play with zkllvm without installing lots of dependencies.
It can also be used to test whether or not latest versions of all repositories build together.


## Getting started

To build zkllvm and related utilities, just do:

```sh
nix build
```

And wait. After 30 minutes or so, you should have everything built correctly in the `result/` directory.

## Compiling circuits


./result/bin/clang -target assigner -I./result/include/zkllvm/c++ -I./result/include/zkllvm -D__ZKLLVM__ -emit-llvm -S -o circuit.ll strlen.cpp

./result/bin/llvm-link -S -o final_circuit.ll circuit.ll ./result/lib/zkllvm/zkllvm-libc.ll

./result/bin/assigner -b final_circuit.ll -i strlen.inp -t assignment.tbl -c circuit.crct -e pallas

checking:

../result/bin/assigner -b final_circuit.ll -i strlen.inp -t assignment.tbl -c circuit.crct -e pallas --check
