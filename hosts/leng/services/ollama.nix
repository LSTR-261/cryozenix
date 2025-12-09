{
  services.ollama = {
    enable = false;
    # acceleration = "cuda";
    host = "0.0.0.0";
    user = "ollama";
    group = "media";
    loadModels = [
      "qwen3-vl:2b"
    ];
    models = "/storage/ollama";
    openFirewall = true;
  };
}
