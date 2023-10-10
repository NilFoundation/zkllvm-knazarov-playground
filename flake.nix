{
  description = "zkllvm playground";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs"; # also valid: "nixpkgs";
    zkllvm = {
      url = "github:NilFoundation/zkllvm";
      flake = false;
    };
    assigner = {
      url = "github:NilFoundation/zkllvm-assigner";
      flake = false;
    };
    blueprint = {
      url = "github:NilFoundation/zkllvm-blueprint";
      flake = false;
    };
    circifier = {
      url = "github:NilFoundation/zkllvm-circifier";
      flake = false;
    };
    boost_cmake = {
      url = "github:BoostCMake/cmake_modules";
      flake = false;
    };
    crypto3 = {
      url = "github:NilFoundation/crypto3";
      flake = false;
    };
    crypto3_algebra = {
      url = "github:NilFoundation/crypto3-algebra";
      flake = false;
    };
    crypto3_block = {
      url = "github:NilFoundation/crypto3-block";
      flake = false;
    };
    crypto3_codec = {
      url = "github:NilFoundation/crypto3-codec";
      flake = false;
    };
    crypto3_containers = {
      url = "github:NilFoundation/crypto3-containers";
      flake = false;
    };
    crypto3_hash = {
      url = "github:NilFoundation/crypto3-hash";
      flake = false;
    };
    crypto3_kdf = {
      url = "github:NilFoundation/crypto3-kdf";
      flake = false;
    };
    crypto3_mac = {
      url = "github:NilFoundation/crypto3-mac";
      flake = false;
    };
    crypto3_math = {
      url = "github:NilFoundation/crypto3-math";
      flake = false;
    };
    crypto3_modes = {
      url = "github:NilFoundation/crypto3-modes";
      flake = false;
    };
    crypto3_multiprecision = {
      url = "github:NilFoundation/crypto3-multiprecision";
      flake = false;
    };
    crypto3_passhash = {
      url = "github:NilFoundation/crypto3-passhash";
      flake = false;
    };
    crypto3_pbkdf = {
      url = "github:NilFoundation/crypto3-pbkdf";
      flake = false;
    };
    crypto3_pkpad = {
      url = "github:NilFoundation/crypto3-pkpad";
      flake = false;
    };
    crypto3_pubkey = {
      url = "github:NilFoundation/crypto3-pubkey";
      flake = false;
    };
    crypto3_random = {
      url = "github:NilFoundation/crypto3-random";
      flake = false;
    };
    crypto3_stream = {
      url = "github:NilFoundation/crypto3-stream";
      flake = false;
    };
    crypto3_threshold = {
      url = "github:NilFoundation/crypto3-threshold";
      flake = false;
    };
    crypto3_vdf = {
      url = "github:NilFoundation/crypto3-vdf";
      flake = false;
    };
    crypto3_zk = {
      url = "github:NilFoundation/crypto3-zk";
      flake = false;
    };
    transpiler = {
      url = "github:NilFoundation/zkllvm-transpiler";
      flake = false;
    };
    crypto3_algebra_marshalling = {
      url = "github:NilFoundation/crypto3-algebra-marshalling";
      flake = false;
    };
    crypto3_multiprecision_marshalling = {
      url = "github:NilFoundation/crypto3-multiprecision-marshalling";
      flake = false;
    };
    crypto3_zk_marshalling = {
      url = "github:NilFoundation/crypto3-zk-marshalling";
      flake = false;
    };
    marshalling = {
      url = "github:NilFoundation/marshalling";
      flake = false;
    };
    stdlib = {
      url = "github:NilFoundation/zkllvm-stdlib";
      flake = false;
    };
    rslang = {
      url = "github:NilFoundation/zkllvm-rslang";
      flake = false;
    };

    # for proof-market-toolchain
    proof-market-toolchain = {
      url = "github:NilFoundation/proof-market-toolchain";
      flake = false;
    };
    pm_assigner = {
      url =
        "github:NilFoundation/zkllvm-assigner?ref=d9325d6428bbe08c144676dfad7a0bea5b9f1bf4";
      flake = false;
    };
    pm_blueprint = {
      url =
        "github:NilFoundation/zkllvm-blueprint?ref=4a98b9919d8a0bc4a17510384072038954be05aa";
      flake = false;
    };
    pm_circifier = {
      url =
        "github:NilFoundation/zkllvm-circifier?ref=65a087de455b481e6d0c3b5b2e3e152097ea9bb6";
      flake = false;
    };
    pm_crypto3_hash = {
      url =
        "github:NilFoundation/crypto3-hash?ref=9b1d470036b837294c8768611a5ae83597065e7f";
      flake = false;
    };
    pm_crypto3_zk = {
      url =
        "github:NilFoundation/crypto3-zk?ref=ff9ef973625254c761e3ef6647fe9cecfb07642d";
      flake = false;
    };
    pm_transpiler = {
      url =
        "github:NilFoundation/zkllvm-transpiler?ref=b5fb9115404fa6a581dddd88c4068b2844ea43ad";
      flake = false;
    };
    pm_crypto3_zk_marshalling = {
      url =
        "github:NilFoundation/crypto3-zk-marshalling?ref=6479d8ab50ea2d3f272dcc97bfaa438232e669aa";
      flake = false;
    };
    application = {
      url = "github:NilFoundation/application";
      flake = false;
    };
    module = {
      url = "github:NilFoundation/module";
      flake = false;
    };
    crypto3_blueprint = {
      url = "github:NilFoundation/crypto3-blueprint";
      flake = false;
    };
    plugin = {
      url = "github:NilFoundation/plugin";
      flake = false;
    };
    actor_blueprint = {
      url =
        "github:NilFoundation/actor-blueprint?ref=afee9b054b940da60280a8ef3f8bf54dbe127a9a";
      flake = false;
    };
    actor_cluster = {
      url = "github:NilFoundation/actor-cluster";
      flake = false;
    };
    actor_container = {
      url = "github:NilFoundation/actor-containers";
      flake = false;
    };
    actor_core = {
      url = "github:NilFoundation/actor-core";
      flake = false;
    };
    actor_zk = {
      url = "github:NilFoundation/actor-zk";
      flake = false;
    };
    dpdk = {
      url = "github:NilFoundation/dpdk";
      flake = false;
    };
    actor_math = {
      url = "github:NilFoundation/actor-math";
      flake = false;
    };
    actor_network = {
      url = "github:NilFoundation/actor-network";
      flake = false;
    };
    epoll_shim = {
      url = "github:NilFoundation/epoll-shim";
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
