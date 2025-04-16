{ ... }: {
  services.glance = {
    enable = true;
    settings = {
      server.port = 2048;
      theme = {
        background-color = "0 0 5"; # TODO: correct would be 4.71 not 5, but seems it's not supported
      };
      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "rss";
                  limit = 10;
                  collapse-after = 3;
                  cache = "12h";
                  feeds = [
                    {
                      url = "https://selfh.st/rss/";
                      title = "selfh.st";
                      limit = 4;
                    }
                    {
                      url = "https://ciechanow.ski/atom.xml";
                    }
                    {
                      url = "https://www.joshwcomeau.com/rss.xml";
                      title = "Josh Comeau";
                    }
                    {
                      url = "https://samwho.dev/rss.xml";
                    }
                    {
                      url = "https://ishadeed.com/feed.xml";
                      title = "Ahmad Shadeed";
                    }
                  ];
                }
                {
                  type = "twitch-channels";
                  channels = [
                    "theprimeagen"
                    "piratesoftware"
                  ];
                }
                {
                  type = "releases";
                  cache = "1d";
                  repositories = [
                    "NixOS/nixpkgs"
                    "immich-app/immich"
                    "syncthing/syncthing"
                    "Aider-AI/aider"
                    "neovim/neovim"
                  ];
                }
                # {
                #   type = "markets"; # TODO: To fix, update nixpkgs version
                #   markets = [
                #     {
                #       symbol = "SPY";
                #       name = "S&P 500";
                #     }
                #     {
                #       symbol = "BTC-USD";
                #       name = "Bitcoin";
                #     }
                #     {
                #       symbol = "NVDA";
                #       name = "NVIDIA";
                #     }
                #     {
                #       symbol = "AAPL";
                #       name = "Apple";
                #     }
                #     {
                #       symbol = "MSFT";
                #       name = "Microsoft";
                #     }
                #   ];
                # }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    { type = "hacker-news"; }
                  ];
                }
                {
                  type = "videos";
                  channels = [
                    "UCR-DXc1voovS8nhAvccRZhg" # Jeff Geerling
                    "UCsBjURrPoezykLs9EqgamOA" # Fireship
                    "UCHnyfMqiRRG1u-2MsSQLbXA" # Veritasium
                  ];
                }
                {
                  type = "group";
                  widgets = [
                    {
                      type = "reddit";
                      subreddit = "technology";
                      show-thumbnails = true;
                    }
                    {
                      type = "reddit";
                      subreddit = "selfhosted";
                      show-thumbnails = true;
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
