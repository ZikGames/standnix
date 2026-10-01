{
  flake.nixosModules.acme =
    let
      domainName = "zkdl.online";
    in
    {
      security.acme = {
        acceptTerms = true;
        defaults.email = "flaimbux2007@gmail.com";
        certs = {
          "${domainName}" = {
            extraDomainNames = [
              "mail.${domainName}"
              "www.${domainName}"
            ];
          };
        };
      };
    };
}
