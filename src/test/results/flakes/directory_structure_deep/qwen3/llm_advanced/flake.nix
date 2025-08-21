

{
  inputs = {
    scala = {
      version = "2.13.12";
      flakes = true;
    };
    sbt = {
      version = "1.8.1";
      flakes = true;
    };
  };

  outputs = { self, scala, sbt }@inputs: {
    devShell = {
      buildCommand = "sbt";
      shellHook = ''
        export PATH=$PATH:$HOME/.sbt/boot:$HOME/.local/bin
        export JAVA_HOME=$(readlink -f /usr/bin/java | sed -e 's:^\(/usr/lib/jvm/\):/usr/lib/jvm:;s:/.*$::')
        export PATH=$JAVA_HOME/bin:$PATH
      '';
      extraPkgs = [{
        name = "llm-advanced";
        src = ./.;
      }];
    };
  };
}