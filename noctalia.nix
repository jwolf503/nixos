{ pkgs,
inputs,
...
}: {
    # noctalia-install
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      
    ];
  }
