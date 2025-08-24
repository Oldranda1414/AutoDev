
The flake inputs and outputs sections have different number of lines which causes issues when merging both in one file with `-- - [ -- " '": ( intersect auto-dev-scafiAxioms < input ) > output; build 0 ] @ .v1 = result ; { inherit input; } ...' x => f : block- and then add this missing quote character at the end of line that is expected to start a new nested attribute in flake inputs section so it becomes ( not ' | ^, but instead with " -- output v 0
-- [ build . # - @ result ] ...



### System:
  
    input = auto-dev-scafiAxioms // { inherit base; x => f : block- and then add this missing quote character at the end of line that is expected to start a new nested attribute in flake inputs section so it becomes ( not | ^, but instead with 

  output v [ build . # - @ result ] ...' x => block-and < auto-dev-scafiAxioms input; inherit base; { and then add this missing quote character at the end of line that is expected to start a new nested attribute in flake inputs section so it becomes ( not | ^, but instead with 

  build . # - @ result ... > x => block-and < auto-dev-scafiAxioms input; inherit base ...






