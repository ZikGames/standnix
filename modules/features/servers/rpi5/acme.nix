{ config, ... }:
{
  flake.nixosModules.acme =
    let
      domainName = "zkdl.online";
    in
    {
      security.acme = {
        acceptTerms = true;
        defaults.email = "admin@${domainName}";
        certs = {
          "${domainName}" = {
            group = config.services.nginx.group;
            extraDomainNames = [
              "mail.${domainName}"
              "www.${domainName}"
            ];
          };
        };
      };
    };
}
