{
  flake.nixosModules.acme =
    let
      domainName = "zkdl.online";
    in
    {
      services.httpd = {
        enable = true;
        adminAddr = "admin@${domainName}";

        extraModules = [
          "lua"
        ];

        virtualHosts."${domainName}" = {
          enableACME = true;
          forceSSL = true;

          documentRoot = "/home/zik/programs/nix/zkdl/www/${domainName}";
        };
      };
      security.acme = {
        acceptTerms = true;
        defaults.email = "admin@${domainName}";
        certs = {
          "${domainName}" = {
            extraDomainNames = [
              "mail.${domainName}"
              "www.${domainName}"
              "pihole.${domainName}"
            ];
          };
        };
      };
    };
}
