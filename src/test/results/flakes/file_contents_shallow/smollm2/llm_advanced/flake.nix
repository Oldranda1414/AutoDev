nix
{
  llm_advanced =
      import ./../../../lib
        ./main.scala
        ./test/scala/sbt-launch.vim
        ./test/scala/sbt-assembly.vim
        ./test/scala/sbt-assembly-resources.vim
        ./test/scala/sbt-assembly-resources-main.vim;
}
