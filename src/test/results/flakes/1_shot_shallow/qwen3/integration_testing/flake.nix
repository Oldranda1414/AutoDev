

{
  inputs = {
    scala-2.12: {
      url = "https://github.com/scala/scala.git";
      rev = "2.12.18";
    };
    scala-2.13: {
      url = "https://github.com/scala/scala.git";
      rev = "2.13.13";
    };
    sbt: {
      url = "https://github.com/sbt/sbt.git";
      rev = "1.9.8";
    };
  };
  outputs = { self, scala-2.12, scala-2.13, sbt }@{
    default = import ./default.nix {
      scala-2.12 = scala-2.12;
      scala-2.13 = scala-2.13;
      sbt = sbt;
    };
  };
}