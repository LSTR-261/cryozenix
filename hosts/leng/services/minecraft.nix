{
  networking.firewall.allowedTCPPorts = [25565];
  networking.firewall.allowedUDPPorts = [25565 24454];
  virtualisation.oci-containers.containers = {
    # prominence-ii = {
    #   image = "itzg/minecraft-server:java17";
    #   autoStart = false;
    #   ports = ["25565:25565"];
    #   volumes = ["/var/lib/minecraft/prominence-ii:/data"];
    #   environment = {
    #     EULA = "TRUE";
    #     TYPE = "MODRINTH";
    #     VERSION = "LATEST";
    #     MODRINTH_MODPACK = "prominence-2-fabric";
    #     MODRINTH_DEFAULT_EXCLUDE_INCLUDES = "";
    #     MODRINTH_PROJECTS = "emi";
    #     MODRINTH_DOWNLOAD_DEPENDENCIES = "required";
    #     MEMORY = "8G";
    #     # USE_AIKAR_FLAGS = "true";
    #   };
    #   extraOptions = [
    #     "--health-start-period=600s"
    #     "--health-retries=20"
    #     "--env=HEALTHCHECK_SILENT=true"
    #   ];
    # };
    # integrated-mc = {
    #   image = "itzg/minecraft-server:java17";
    #   autoStart = true;
    #   ports = ["25565:25565"];
    #   volumes = ["/var/lib/minecraft/integrated-mc:/data" "/home/lstr-261/Minecraft/integrated-mc:/downloads"];
    #   environment = {
    #     EULA = "TRUE";
    #     MODPACK_PLATFORM = "AUTO_CURSEFORGE";
    #     VERSION = "LATEST";
    #     CF_SLUG = "integrated-minecraft";
    #     CF_API_KEY = "$2a$10$3D7RDikED4z/6xuSMUAyFOzZVn4kkP3AloVJlDBIhLDKKW.npTxBO";
    #     CF_EXCLUDE_MODS = "automodpack";

    #     MEMORY = "8G";
    #   };
    #   extraOptions = [
    #     "--health-start-period=600s"
    #     "--health-retries=20"
    #     "--env=HEALTHCHECK_SILENT=true"
    #   ];
    # };
  };
  services.caddy.virtualHosts."mc.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:25565
  '';
}
