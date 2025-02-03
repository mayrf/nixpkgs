{ lib, stdenv, kclvm }:
kclvm.overrideAttrs (oldAttrs: rec {
  pname = "kcl-lsp";
  version = "0.10.0";

  buildPhase = ''
    echo "Building the application"
    cargo build --package kcl-language-server --release
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp target/release/kcl-language-server $out/bin/
  '';

  postInstall = "";

  meta = {
    description = "A languague server for KCL programming language";
    changelog = "https://github.com/kcl-lang/kcl/releases/tag/v${version}";
    homepage = "https://github.com/kcl-lang/kcl";
    license = lib.licenses.asl20;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    maintainers = with lib.maintainers; [ peefy selfuryon mayrf ];
    mainProgram = "kcl";
    broken = stdenv.buildPlatform != stdenv.hostPlatform;
  };
})
