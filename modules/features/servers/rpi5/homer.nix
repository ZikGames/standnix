{
  flake.nixosModules.homer = {
    services.homer = {
      enable = true;
      virtualHost.caddy.enable = true;
      settings = ''
        {
          title = "App dashboard";
          subtitle = "Homer";
          logo = "assets/logo.png";
          header = true;
          footer = '''
            <p>Created with <span class="has-text-danger">❤️</span> with
            <a href="https://bulma.io/">bulma</a>,
            <a href="https://vuejs.org/">vuejs</a> &
            <a href="https://fontawesome.com/">font awesome</a> //
            Fork me on <a href="https://github.com/bastienwirtz/homer">
            <i class="fab fa-github-alt"></i></a></p>
          ''';
          columns = "3";
          connectivityCheck = true;

          proxy = {
            useCredentials = false;
            headers = {
              Test = "Example";
              Test1 = "Example1";
            };
          };

          defaults = {
            layout = "columns";
            colorTheme = "auto";
          };

          theme = "default";

          message = {
            style = "is-warning";
            title = "Optional message!";
            icon = "fa fa-exclamation-triangle";
            content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
          };

          links = [
            {
              name = "Link 1";
              icon = "fab fa-github";
              url = "https://github.com/bastienwirtz/homer";
              target = "_blank";
            }
            {
              name = "link 2";
              icon = "fas fa-book";
              url = "https://github.com/bastienwirtz/homer";
            }
          ];

          services = [
            {
              name = "Application";
              icon = "fas fa-code-branch";
              items = [
                {
                  name = "Awesome app";
                  logo = "assets/tools/sample.png";
                  subtitle = "Bookmark example";
                  tag = "app";
                  keywords = "self hosted reddit";
                  url = "https://www.reddit.com/r/selfhosted/";
                  target = "_blank";
                }
                {
                  name = "Another one";
                  logo = "assets/tools/sample2.png";
                  subtitle = "Another application";
                  tag = "app";
                  tagstyle = "is-success";
                  url = "#";
                }
              ];
            }
            {
              name = "Other group";
              icon = "fas fa-heartbeat";
              items = [
                {
                  name = "Pi-hole";
                  logo = "assets/tools/sample.png";
                  tag = "other";
                  url = "http://192.168.0.151/admin";
                  type = "PiHole";
                  target = "_blank";
                }
              ];
            }
          ];
        }

      '';
      virtualHost.domain = "zkdl.online";
    };
  };
}
