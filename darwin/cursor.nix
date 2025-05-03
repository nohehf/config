{
  lib,
  stdenvNoCC,
  fetchurl,
  undmg,
  makeWrapper,
}:

let
  # Full list of versions: https://github.com/oslook/cursor-ai-downloads/blob/main/version-history.json
  pname = "code-cursor";
  version = "0.49.6";
  url = "https://downloads.cursor.com/production/0781e811de386a0c5bcb07ceb259df8ff8246a52/darwin/universal/Cursor-darwin-universal.dmg";
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = fetchurl {
    inherit url;
    sha256 = "3e750dea72ddbbbe3c0d8b5b2cee79ceaf3f839b34ba2fca15b6fa35c3372301";
  };

  nativeBuildInputs = [
    undmg
    makeWrapper
  ];

  # Important otherwise the app will be in quarantine -- see: https://github.com/NixOS/nixpkgs/issues/320494
  dontFixup = true;

  unpackPhase = "undmg $src";

  installPhase = ''
    mkdir -p $out/Applications
    mv Cursor.app $out/Applications/
    makeWrapper "$out/Applications/Cursor.app/Contents/MacOS/Cursor" \
                "$out/bin/cursor"
  '';

  meta = with lib; {
    description = "Cursor code editor (universal macOS .dmg)";
    homepage = "https://cursor.sh";
    # license = licenses.unfree;
    platforms = platforms.darwin;
  };
}
