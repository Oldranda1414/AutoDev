{ 
  description = "My project"; 
  inputs = {flake-utils}: rec { 
    project = file:///home/randa/AutoDev/src/test/space/llm_advanced; 
    shellHook = ''
      cd $project;
      export JVM_OPTS=-Xmx2g -XX:+UseG1GC -Dawt.toolkit=sun.awt.X11GraphicsEnvironment
    '';
  };