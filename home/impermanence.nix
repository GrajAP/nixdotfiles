{lib, ...}: let
  inherit (lib) forEach;
in {
  home.persistence."/persist/home/grajap" = {
    allowOther = true;
    directories =
      [
#       "download"
#       "music"
#       "dev"
#       "docs"
#       "pics"
#       "vids"
#       "other"
              ]
      ++ forEach [ "Caprine" "VencordDesktop" "obs-studio" "Signal"] (
        x: ".config/${x}"
      )
      ++ forEach ["tealdeer" "keepassxc" "nix" "starship" "nix-index" "mozilla" "go-build"] (
        x: ".cache/${x}"
      )
      ++ forEach ["direnv" "TelegramDesktop" "keyrings"] (x: ".local/share/${x}")
      ++ [".ssh" ".keepass" ".mozilla"];
  };
}
