{
  description = "zkllvm playground";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs"; # also valid: "nixpkgs";
    zkllvm = {
      url = "git+https://github.com/NilFoundation/zkllvm?submodules=1";
      flake = false;
    };
    boost_cmake = {
      url = "github:BoostCMake/cmake_modules";
      flake = false;
    };
    proof-market-toolchain = {
      url = "git+https://github.com/NilFoundation/proof-market-toolchain?submodules=1";
      flake = false;
    };
  };

  # Flake outputs
  outputs = { self, nixpkgs, ... }@repos_input:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];
      repos = repos_input // { playground = self; };

      # Helper to provide system-specific attributes
      forAllSystems = f:
        nixpkgs.lib.genAttrs allSystems
        (system: f { pkgs = import nixpkgs { inherit system; }; });
    in {
      packages = forAllSystems ({ pkgs }: rec {
        zkllvm = (pkgs.callPackage ./zkllvm.nix {
          repos = repos;
          stdenv = pkgs.llvmPackages_16.stdenv;
        });
        proof-market-toolchain =
          (pkgs.callPackage ./proof-market-toolchain.nix {
            repos = repos;
            stdenv = pkgs.llvmPackages_16.stdenv;
          });
        default = zkllvm;
      });
      devShells = forAllSystems ({ pkgs }: rec {
        default = let

            zkllvm = (pkgs.callPackage ./zkllvm.nix {
              repos = repos;
              stdenv = pkgs.llvmPackages_16.stdenv;
            });
            proof-market-toolchain = pkgs.enableDebugging (pkgs.callPackage ./proof-market-toolchain.nix {
              repos = repos;
              stdenv = pkgs.llvmPackages_16.stdenv;
            });
        in
          pkgs.mkShell {
          buildInputs = [
            zkllvm
            proof-market-toolchain
            pkgs.gdb
          ];
          shellHook =
          ''
            export ZKLLVM=${zkllvm}
          '';
        };
      });
    };
}
