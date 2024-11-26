New machine checklist:

* Install consolas font by clicking on `./Consolas.tff`
* Set tracking speed, key repeat and delay
* Copy OSX App Shortcuts to `~/Library/Preferences/.GlobalPreferences.plist` [NOTE: requires restart]
* Install brew, and load default set of software:
  * `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
  * `xargs brew install < brew-all.txt`
* Load `iTerm_default.json` profile settings, and additionally set:
  * `Left Command ⌘` to `Left Control ⌃`
  * `Right Command ⌘` to `Left Option ⌥`
  * `General` > `Selection` > `Applications in terminal may access clipboard`
