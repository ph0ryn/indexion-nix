{
  lib,
  makeWrapper,
  stdenvNoCC,
}:

let
  version = "0.18.0";
  releases = {
    aarch64-darwin = {
      archive = "indexion-darwin-arm64.tar.gz";
      hash = "sha256-DJE1IaTF02q1xdZxaB9Lup0V8eAuH7r8WSQkqPN6Q5s=";
    };
    x86_64-linux = {
      archive = "indexion-linux-x64.tar.gz";
      hash = "sha256-TDRT7JSSt/YY6pMGyivJbb0Q/0vtqgRIaN5tC0UnrpY=";
    };
  };
  release = releases.${stdenvNoCC.hostPlatform.system};
in
stdenvNoCC.mkDerivation {
  pname = "indexion";
  inherit version;

  src = builtins.fetchurl {
    url = "https://github.com/trkbt10/indexion/releases/download/v${version}/${release.archive}";
    sha256 = release.hash;
  };

  nativeBuildInputs = [ makeWrapper ];
  unpackPhase = "tar -xzf $src";
  sourceRoot = "indexion-${if stdenvNoCC.hostPlatform.isDarwin then "darwin-arm64" else "linux-x64"}";

  installPhase = ''
    mkdir -p $out/libexec
    cp -R . $out/libexec/indexion
    mkdir -p $out/bin
    makeWrapper $out/libexec/indexion/indexion $out/bin/indexion \
      --set INDEXION_KGFS_DIR $out/libexec/indexion/kgfs
  '';

  meta = {
    description = "Source code exploration and documentation tool";
    homepage = "https://github.com/trkbt10/indexion";
    license = lib.licenses.asl20;
    platforms = [
      "aarch64-darwin"
      "x86_64-linux"
    ];
    mainProgram = "indexion";
  };
}
