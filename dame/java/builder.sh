export PATH="$coreutils/bin:$jdk/bin:$jre/bin"
mkdir $out
source $makeWrapper/nix-support/setup-hook
javac $src/$className.java -d $out
mkdir -p $out/share/java
jar -cf $out/share/java/Queen.jar -C $out $className.class
export SHELL=$bash/bin/bash
makeWrapper $jre/bin/java $out/bin/Queen --add-flags "-cp $out/share/java/Queen.jar $className"
