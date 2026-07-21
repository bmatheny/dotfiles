# Apps

Human-readable inventory of the GUI applications I run on macOS. The machine-
readable source of truth is the `if OS.mac?` block at the bottom of
`support/packages/Brewfile` (casks + Mac App Store entries) — **keep these two
in sync.** Last reconciled 2026-07-21 against `/Applications` and the curated
installer stash in `~/SynologyDrive/Home/Apps`.

Install method: `cask` = Homebrew cask, `mas` = Mac App Store (with app id).

## Password manager
* 1Password — `cask 1password`
* 1Password CLI — `cask 1password-cli`

## Launcher, window & menu bar
* Alfred 5 — `cask alfred` (launcher, built-in backup; still my launcher — Raycast was tried and dropped, it no longer works)
* Rectangle Pro — `cask rectangle-pro` (window manager; installed as a cask, not App Store)
* Witch — `cask witch`, mackup backup
* Thaw — `cask thaw` (menu-bar manager)

## Terminal & editors
* iTerm2 — `cask iterm2`, built-in backup
* Cursor — `cask cursor`
* Qt Creator — `cask qt-creator`
* Xcode — `mas Xcode, id 497799835`

## Cloud, sync & networking
* Synology Drive Client — `cask synology-drive` (**bootstrap prerequisite** — pulls down configs/keys)
* Google Drive — `cask google-drive`
* Tailscale — `cask tailscale`
* WiFiman — `cask wifiman`
* NordVPN — `mas NordVPN, id 905953485`
* WireGuard — `mas WireGuard, id 1451685025`
* Windows App — `mas Windows App, id 1295203466`

## AI / notes / productivity
* Claude — `cask claude`
* Claude Code — `cask claude-code`
* Notion — `cask notion`
* Notion CLI — `cask notion-cli`
* Antinote — `cask antinote`
* Marked 2 — `mas Marked 2, id 890031187`
* Things 3 — `mas Things, id 904280696`
* Amphetamine — `mas Amphetamine, id 937984704`

## Media & audio
* Spotify — `cask spotify`, mackup backup
* Tidal — `cask tidal`
* Sonos — `cask sonos`
* BluOS Controller — `cask bluos-controller`
* VLC — `cask vlc`
* Balance Lock — `mas Balance Lock, id 1019371109`

## Peripherals
* Elgato Stream Deck — `cask elgato-stream-deck`
* Logi Tune — `cask logitune`
* Logi Options+ — `cask logi-options-plus`
* HP Smart — `mas HP Smart, id 1474276998`

## 3D printing / CAD / maker
* Bambu Studio — `cask bambu-studio`
* OrcaSlicer — `cask orcaslicer`
* PrusaSlicer — `cask prusaslicer`
* OpenSCAD — `cask openscad`
* Autodesk Fusion — `cask autodesk-fusion`

## SDR / radio
* Gqrx — `cask gqrx` (see also the SDR CLI tools in the formulae section: `rtl_433`, `urh`, `inspectrum`, `dfu-util`)

## Utilities
* AppCleaner — `cask appcleaner`
* QuitAll — `cask quitall`
* balenaEtcher — `cask balenaetcher`
* macFUSE — `cask macfuse`
* sshfs-mac — `cask sshfs-mac`
* Cursr — `cask cursr`
* FileBot — `cask filebot`
* MQTT Explorer — `cask mqtt-explorer` (was a `mas` entry; I run the beta dmg instead)
* Zoom — `cask zoom`
* Slack — `mas Slack, id 803453959`

## Fonts
* Inconsolata Nerd Font — `cask font-inconsolata-nerd-font`
* Meslo for Powerline — `cask font-meslo-for-powerline`

## Not captured here
* Immich desktop — installed manually; no matching Homebrew cask as of this writing.
