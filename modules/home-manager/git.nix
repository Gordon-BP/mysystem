{inputs, ...}: {
  programs.git = {
    enable = true;
    userName = "Gordon-BP";
    userEmail = "gordynumberone@protonmail.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commuit";
    };
  };
}
