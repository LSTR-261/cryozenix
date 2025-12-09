{
  services.grafana = {
    enable = true;
    settings.server = {
      http_addr = "0.0.0.0";
      http_port = 5005;
      root_url = "https://grafana.lstr-261.eu";
    };
    openFirewall = true;
  };
  services.prometheus = {
    enable = true;
    port = 6006;
    extraFlags = ["--web.enable-remote-write-receiver"];
    webExternalUrl = "https://prometheus.lstr-261.eu";
  };
  services.alloy = {
    enable = true;
    extraFlags = ["--server.http.listen-addr=0.0.0.0:12346"];
  };
  networking.firewall.allowedTCPPorts = [12346];
  environment.etc."alloy/config.alloy".text = ''
    prometheus.exporter.unix "metrics" {
        disable_collectors = ["ipvs", "btrfs", "infiniband", "xfs", "zfs"]
        enable_collectors = ["meminfo"]

        filesystem {
            fs_types_exclude     = "^(autofs|binfmt_misc|bpf|cgroup2?|configfs|debugfs|devpts|devtmpfs|tmpfs|fusectl|hugetlbfs|iso9660|mqueue|nsfs|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|selinuxfs|squashfs|sysfs|tracefs)$"
            mount_points_exclude = "^/(dev|proc|run/credentials/.+|sys|var/lib/docker/.+)($|/)"
            mount_timeout        = "5s"
        }

        netclass {
            ignored_devices = "^(veth.*|cali.*|[a-f0-9]{15})$"
        }

        netdev {
            device_exclude = "^(veth.*|cali.*|[a-f0-9]{15})$"
        }
    }

    discovery.relabel "metrics" {
        targets = prometheus.exporter.unix.metrics.targets

        rule {
            target_label = "instance"
                replacement  = constants.hostname
        }

        rule {
            target_label = "job"
            replacement = string.format("%s-metrics", constants.hostname)
        }
    }

    prometheus.scrape "metrics" {
        scrape_interval = "15s"
        targets = discovery.relabel.metrics.output
        forward_to = [prometheus.remote_write.metrics.receiver]
    }

    prometheus.remote_write "metrics" {
        endpoint {
            url = "http://leng.fritz.box:6006/api/v1/write"
        }
    }
  '';

  services.caddy.virtualHosts."grafana.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:5005
  '';
  services.caddy.virtualHosts."prometheus.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:6006
  '';
}
