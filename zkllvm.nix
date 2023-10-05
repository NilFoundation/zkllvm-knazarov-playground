{ lib, stdenv, pkgs,
  repos,

}:
stdenv.mkDerivation rec {
  pname = "zkllvm";
  version = "0.1.0";

  src = repos.zkllvm;

  nativeBuildInputs = with pkgs; [ cmake ];

  dontFixCmake = true;

  buildInputs = with pkgs; [

    git
    python3
    (boost182.override {enableStatic = true;})
    spdlog
    (pkgs.callPackage ./boost_cmake.nix {
      stdenv = stdenv;
      repos = repos;
    })
  ];
  sourceRoot = "source";
  unpackPhase = ''
      unpackFile "${src}"
      chmod -R u+rw ./source

      cp -rT --no-preserve=mode,ownership "${repos.crypto3}"/ ./source/libs/crypto3
      cp -rT --no-preserve=mode,ownership "${repos.blueprint}"/ ./source/libs/blueprint
      cp -rT --no-preserve=mode,ownership "${repos.assigner}"/ ./source/libs/assigner
      cp -rT --no-preserve=mode,ownership "${repos.transpiler}"/ ./source/libs/transpiler
      cp -rT --no-preserve=mode,ownership "${repos.circifier}"/ ./source/libs/circifier
      cp -rT --no-preserve=mode,ownership "${repos.stdlib}"/ ./source/libs/stdlib
      cp -rT --no-preserve=mode,ownership "${repos.rslang}"/ ./source/libs/rslang
      chmod -R u+rwx ./source/libs/rslang

      cp -rT --no-preserve=mode,ownership "${repos.crypto3_algebra}"/ ./source/libs/crypto3/libs/algebra
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_block}"/ ./source/libs/crypto3/libs/block
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_codec}"/ ./source/libs/crypto3/libs/codec
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_containers}"/ ./source/libs/crypto3/libs/containers
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_hash}"/ ./source/libs/crypto3/libs/hash
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_kdf}"/ ./source/libs/crypto3/libs/kdf
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_mac}"/ ./source/libs/crypto3/libs/mac
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_math}"/ ./source/libs/crypto3/libs/math
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_modes}"/ ./source/libs/crypto3/libs/modes
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_multiprecision}"/ ./source/libs/crypto3/libs/multiprecision
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_passhash}"/ ./source/libs/crypto3/libs/passhash
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_pbkdf}"/ ./source/libs/crypto3/libs/pbkdf
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_pkpad}"/ ./source/libs/crypto3/libs/pkpad
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_pubkey}"/ ./source/libs/crypto3/libs/pubkey
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_random}"/ ./source/libs/crypto3/libs/random
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_stream}"/ ./source/libs/crypto3/libs/stream
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_threshold}"/ ./source/libs/crypto3/libs/threshold
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_vdf}"/ ./source/libs/crypto3/libs/vdf
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_zk}"/ ./source/libs/crypto3/libs/zk


      cp -rT --no-preserve=mode,ownership "${repos.crypto3_algebra_marshalling}"/ ./source/libs/crypto3/libs/marshalling/algebra
      cp -rT --no-preserve=mode,ownership "${repos.marshalling}"/ ./source/libs/crypto3/libs/marshalling/core
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_multiprecision_marshalling}"/ ./source/libs/crypto3/libs/marshalling/multiprecision
      cp -rT --no-preserve=mode,ownership "${repos.crypto3_zk_marshalling}"/ ./source/libs/crypto3/libs/marshalling/zk
  '';

  patches = [ ./cm.diff ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}/zkllvm"
    "-DBoost_USE_STATIC_LIBS=FALSE"
    "-DZKLLVM_VERSION=0.1.0"
  ];
}
