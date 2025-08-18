{ 
flakeName = "acceptance-testing"; 
inputs = last: lib: {
pkgs, ...}: {
devShells.default = pkgs.mkShell {
  name = "acceptance-testing";
  buildInputs = with pkgs; [
    openjdk
    sbt
  ];
  shellHook = ''
    export CLASSPATH=$CLASSPATH:$HOME/.sbt/stubs/
    sbt
  '';
};
};