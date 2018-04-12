echo "Building Java"
echo ""
cd java
nix-build -Q dame.nix
echo ""
echo "Running Java"
result/bin/Queen
echo ""
echo "Building Haskell"
cd ../haskell
nix-build -Q release.nix
echo ""
echo "Running Haskell"
result/bin/dame
echo ""
echo "Done."
