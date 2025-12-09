{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    host = "0.0.0.0";
    loadModels = [
      "qwen3-vl:8b"
    ];
    models = "/storage/ollama";
    openFirewall = true;
  };
  services.caddy.virtualHosts."ollama.s.lstr-261.eu".extraConfig = ''
    reverse_proxy sierpinski.fritz.box:11434
  '';
}
