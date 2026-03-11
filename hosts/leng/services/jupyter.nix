{pkgs, ...}: let
  customPython = pkgs.python3.withPackages (ps:
    with ps; [
      ipykernel
      numpy
      pandas
      matplotlib
      scipy
      requests
      # Add more packages here...
    ]);
in {
  services.jupyter = {
    enable = true;
    ip = "0.0.0.0";
    port = 8888;
    password = "argon2:$argon2id$v=19$m=10240,t=10,p=8$48hF+vTUuy1LB83/GzNhUg$J1nx4jPWD7PwOJHs5OtDW8pjYK2s0c1R3rYGbSIKB54";
    kernels = {
      python3 = {
        displayName = "Python 3 (Custom Environment)";
        language = "python";
        argv = [
          "${customPython.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [8888];
  services.caddy.virtualHosts."python.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:8888
  '';
}
