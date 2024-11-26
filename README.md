New machine checklist:

* Copy dotfiles to home:
```
cp .emacs ~
cp .zshrc ~
```
* Install [ZSH](https://ohmyz.sh/)
* Install consolas font by clicking on `./Consolas.tff`
* Set tracking speed, key repeat (fastest), and key delay (shortest)
* Copy OSX App Shortcuts (requires restart):
```
cp ./GlobalPreferences.plist ~/Library/Preferences/.GlobalPreferences.plist
sudo shutdown -r now
```
* Install [iTerm2](https://iterm2.com/), and additionally set:
  * Load `iTerm_default.json` profile settings
  * `Keys` > `Remap Modifiers` > `Left Command ⌘` to `Left Control ⌃`
  * `Keys` > `Remap Modifiers` > `Right Command ⌘` to `Left Option ⌥`
  * `General` > `Selection` > `Applications in terminal may access clipboard`
* Install [brew](https://brew.sh/), and load default set of software:
```
xargs brew install < brew-all.txt
```
* Setup a GitHub [SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) key, and [GPG](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account) signing key:
```
git config --global user.signingkey <key-id>
git config --global commit.gpgsign true
git config --global tag.gpgSign true
```