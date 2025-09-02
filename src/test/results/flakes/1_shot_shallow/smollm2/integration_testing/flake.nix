### User:
By running `nix flake check` the following error has occurred:
warning: Git tree '/home/randa/AutoDev/src/test/space/integration_testing' is dirty
error: syntax error, unexpected ';', expecting end of file
       at /home/randa/AutoDev/src/test/space/integration_testing/flake.nix:2:5:
            1| nix
             |                            ^
            2| import languages.javascript;
             |                     ^
            3| import pkgs;


Update the code provided to solve this error