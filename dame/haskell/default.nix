{ mkDerivation, base, llvm-hs, llvm-hs-pure, stdenv, vector }:
mkDerivation {
  pname = "dame";
  version = "1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base llvm-hs llvm-hs-pure vector ];
  license = stdenv.lib.licenses.bsd3;
}
