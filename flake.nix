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
  };

  # Flake outputs
  outputs = { self, nixpkgs, ... }@ repos_input:
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
        });
        default = zkllvm;
      });
    };
}
