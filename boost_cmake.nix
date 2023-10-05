{
    pkgs,
    stdenv,
  repos,
}:
stdenv.mkDerivation rec {
  pname = "boost_cmake";
  version = "0.1.0";

  src = repos.boost_cmake;
  nativeBuildInputs = with pkgs; [
      cmake
  ];
}
