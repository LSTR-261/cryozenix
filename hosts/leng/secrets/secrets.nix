let
  lstr-261-leng = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9dEvqch/cuZDQJhB9cHqLf8CAVwrejkS0GjRG2IH1x lstr-261@leng";
  users = [lstr-261-leng];
  leng = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcq32eErhU4Z6hkZ+YEts7+9oCtdI6U1dYXCrkMcslI";
  systems = [leng];
in {
  "authelia/jwtSecret.age".publicKeys = users ++ systems;
  "authelia/storageEncryptionKey.age".publicKeys = users ++ systems;
  "authelia/sessionSecret.age".publicKeys = users ++ systems;
  "authelia/autheliaLldapPassword.age".publicKeys = users ++ systems;
  "authelia/autheliaJwksKey.age".publicKeys = users ++ systems;
  "porkbunApiKey.age".publicKeys = users ++ systems;
  "torboxCredentials.age".publicKeys = users ++ systems;
}
