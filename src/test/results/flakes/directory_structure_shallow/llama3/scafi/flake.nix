{flakeName} = rec {
  src = ./.;

  devShell = pkgs.mkshell ({
    RUBYLIB = "${pkgs.scala_2_13}/bin";
    SBT_OPTS = "-Xmx1g -J-XX:MaxPermSize=256M";

    buildInputs = with pkgs; [ scala_2_13 sbt ];
  });

  outputs = [ devShell ];

  name = "scafi";

  description = "scafi development environment";
};