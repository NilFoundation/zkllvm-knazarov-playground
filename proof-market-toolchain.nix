{ lib, stdenv, pkgs, repos,

}:
# If we compile the proof-producer with anything but clang12, then
# circuits that have "const char*" parameters will lead to the
# proof producer crashing. This is a known problem. See:
# https://github.com/NilFoundation/proof-market-toolchain/pull/86
pkgs.llvmPackages_12.stdenv.mkDerivation rec {
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
  '';

  #preBuild = ''
  #addAutoPatchelfSearchPath ${placeholder "out"}/zkllvm/lib/
  #'';

  patches = [ ./proofmarket-cm.patch ./boost_filesystem.patch ./prepare_statement.patch];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Debug"
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
    cp ../scripts/prepare_statement.py $out/bin
    cp -r libs/zkllvm-circifier/llvm/lib/*so* $out/lib
  '';

  postInstall = "\n";
  preFixup = ''
    patchelf --shrink-rpath --allowed-rpath-prefixes ${builtins.storeDir} "$out/bin/proof-generator"
  '';
}
