### User:

By running `nix flake check` the following error has occurred:

warning: Git tree '/home/randa/AutoDev/src/test/space/scafi' is dirty
error: syntax error, unexpected UPDATE, expecting INHERIT
       at /home/randa/AutoDev/src/test/space/scafi/flake.nix:3:25:
            2|   build: {
             |         update := true;
             |     ^
             |     build: [source]
             |          +-- src/main/scala-33/
             |          ├── resources/
             |          └── scala/
             |          \--- [other files...]


Update the code provided to solve this error