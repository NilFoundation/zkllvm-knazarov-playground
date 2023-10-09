{ lib, stdenv, pkgs, repos,

}:
stdenv.mkDerivation rec {
  pname = "proof-market-toolchain";
  version = "0.1.0";

  src = repos.proof-market-toolchain;

  nativeBuildInputs = with pkgs; [ cmake ];

  dontFixCmake = true;

  buildInputs = with pkgs; [

    git
    python3
    (boost182.override { enableStatic = true; })
    spdlog
    icu
    pkg-config
    c-ares
    lz4
    gnutls
    protobuf
    yaml-cpp
    lksctp-tools
    ragel
    hwloc
    numactl
    (pkgs.callPackage ./boost_cmake.nix {
      stdenv = stdenv;
      repos = repos;
    })
  ];
  sourceRoot = "source";
  unpackPhase = ''
    unpackFile "${src}"
    chmod -R u+rw ./source

    cp -rT --no-preserve=mode,ownership "${repos.pm_assigner}"/ ./source/libs/zkllvm-assigner
    cp -rT --no-preserve=mode,ownership "${repos.pm_transpiler}"/ ./source/libs/zkllvm-transpiler
    cp -rT --no-preserve=mode,ownership "${repos.pm_circifier}"/ ./source/libs/zkllvm-circifier

    cp -rT --no-preserve=mode,ownership "${repos.crypto3_algebra}"/ ./source/libs/algebra
    cp -rT --no-preserve=mode,ownership "${repos.application}"/ ./source/libs/application
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_block}"/ ./source/libs/block
    cp -rT --no-preserve=mode,ownership "${repos.pm_blueprint}"/ ./source/libs/blueprint
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_codec}"/ ./source/libs/codec
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_containers}"/ ./source/libs/containers
    cp -rT --no-preserve=mode,ownership "${repos.pm_crypto3_hash}"/ ./source/libs/hash
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_mac}"/ ./source/libs/mac
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_math}"/ ./source/libs/math
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_modes}"/ ./source/libs/modes
    cp -rT --no-preserve=mode,ownership "${repos.module}"/ ./source/libs/module
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_multiprecision}"/ ./source/libs/multiprecision
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_pkpad}"/ ./source/libs/pkpad
    cp -rT --no-preserve=mode,ownership "${repos.plugin}"/ ./source/libs/plugin
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_pubkey}"/ ./source/libs/pubkey
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_random}"/ ./source/libs/random
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_stream}"/ ./source/libs/stream
    cp -rT --no-preserve=mode,ownership "${repos.pm_crypto3_zk}"/ ./source/libs/zk

    cp -rT --no-preserve=mode,ownership "${repos.crypto3_algebra_marshalling}"/ ./source/libs/marshalling/algebra
    cp -rT --no-preserve=mode,ownership "${repos.marshalling}"/ ./source/libs/marshalling/core
    cp -rT --no-preserve=mode,ownership "${repos.crypto3_multiprecision_marshalling}"/ ./source/libs/marshalling/multiprecision
    cp -rT --no-preserve=mode,ownership "${repos.pm_crypto3_zk_marshalling}"/ ./source/libs/marshalling/zk


    cp -rT --no-preserve=mode,ownership "${repos.actor_blueprint}"/ ./source/libs/actor/blueprint
    cp -rT --no-preserve=mode,ownership "${repos.actor_cluster}"/ ./source/libs/actor/cluster
    cp -rT --no-preserve=mode,ownership "${repos.actor_container}"/ ./source/libs/actor/container
    cp -rT --no-preserve=mode,ownership "${repos.actor_core}"/ ./source/libs/actor/core
    cp -rT --no-preserve=mode,ownership "${repos.dpdk}"/ ./source/libs/actor/dpdk
    cp -rT --no-preserve=mode,ownership "${repos.actor_math}"/ ./source/libs/actor/math
    cp -rT --no-preserve=mode,ownership "${repos.actor_network}"/ ./source/libs/actor/network
    cp -rT --no-preserve=mode,ownership "${repos.actor_zk}"/ ./source/libs/actor/zk
    cp -rT --no-preserve=mode,ownership "${repos.epoll_shim}"/ ./source/libs/actor/shim/epoll

  '';

  #preBuild = ''
  #addAutoPatchelfSearchPath ${placeholder "out"}/zkllvm/lib/
  #'';

  patches = [ ./proofmarket-cm.patch ./boost_filesystem.patch ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    #"-DCMAKE_INSTALL_PREFIX=${placeholder "out"}/zkllvm"
    "-DBoost_USE_STATIC_LIBS=FALSE"
    "-DZKLLVM_VERSION=0.1.0"
    "-DCIRCUIT_ASSEMBLY_OUTPUT=TRUE"
  ];

  buildPhase = ''
    make -j32 proof-generator
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    cp bin/proof-generator/proof-generator $out/bin
    cp -r libs/zkllvm-circifier/llvm/lib/*so* $out/lib
  '';

  postInstall = "\n";
  preFixup = ''
    patchelf --shrink-rpath --allowed-rpath-prefixes ${builtins.storeDir} "$out/bin/proof-generator"
  '';
}
