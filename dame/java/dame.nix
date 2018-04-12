with (import <nixpkgs> {});

let
  className = "Queen";
in
  derivation {
    name = "dame-problem";
    builder = "${bash}/bin/bash";
    args = [ ./builder.sh ];
    inherit jdk jre makeWrapper bash coreutils;
    inherit className;
    system = builtins.currentSystem;
    src = ./files;
  }
