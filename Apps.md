# Apps

Below are a list of pretty much all the GUI applications I use on my mac.

* 1Password - cask 1password
* Adobe Acrobat - cask adobe-acrobat-reader
* Alfred 5 - cask alfred, built in backup
* Balance Lock - mas install
* balenaEtcher - cask balenaetcher
* Bartender 4 - cask bartender, mackup backup
* Divvy - cask divvy, mackup backup (maybe license, yes config)
* Elgato Camera Hub - cask elgato-camera-hub
* Elgato Control Center - cask elgato-control-center
* Elgato Stream Deck - cask elgato-stream-deck
* Google Chrome - cask google-chrome
* iTerm2 - cask iterm2, built in backup
* Krisp - cask krisp
* Logi Options+ - cask logi-options-plus
* SizeUp - cask sizeup, mackup backup (license and config)
* Slack - mas install
* Sonos - cask sonos
* Spotify - cask spotify, mackup backup
* Synology Drive Client - cask synology-drive
* Things3 - mas install
* Tidal - cask tidal
* Witch - cask witch, mackup backup
* Xcode - mas install
* Zoom - cask zoom

## Brewfile

Here is the above materialized into a Brewfile. This is mostly for
reference/documentation for me.

```
# casks
tap "homebrew/cask"
# found elgato camera hub, stream deck, sonos, etc here
tap "homebrew/cask-drivers"
# fonts
tap "homebrew/cask-fonts"
# mac software
tap "homebrew/cask-versions"

brew "mackup"

# TODO: Need to test some templates
cask "1password"
cask "1password-cli"
cask "adobe-acrobat-reader"
cask "alfred"
cask "balenaetcher"
cask "bartender"
cask "divvy"
cask "elgato-camera-hub"
cask "elgato-control-center"
cask "elgato-stream-deck"
cask "google-chrome"
cask "iterm2"
cask "logi-options-plus"
cask "sizeup"
cask "sonos"
cask "spotify"
cask "synology-drive"
cask "tidal"
cask "witch"
cask "zoom"
cask "font-inconsolata-nerd-font"

mas "Things", id: 904280696
```
