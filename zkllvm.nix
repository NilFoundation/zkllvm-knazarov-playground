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
    icu
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

  patches = [
    ./cm.diff
#    ./assigner.diff
    ./purity.patch
    ./gnu-install-dirs.patch
    ./stdlib.patch
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    #"-DCMAKE_INSTALL_PREFIX=${placeholder "out"}/zkllvm"
    "-DBoost_USE_STATIC_LIBS=FALSE"
    "-DZKLLVM_VERSION=0.1.0"
    "-DCIRCUIT_ASSEMBLY_OUTPUT=TRUE"
  ];

  postInstall = ''

  '';
}
