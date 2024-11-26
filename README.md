### New machine checklist

* Create a workspace:
```
mydir ~/Workspace
cd ~/Workspace
```
* Install [brew](https://brew.sh/), pull down this repo (obviously), and load default set of software:
```
brew install git
git clone git@github.com:amcnamara/new-machine.git ~/Workspace/new-machine
cd ~/Workspace/new-machine
xargs brew install < brew-all.txt
```
* Copy dotfiles to home:
```
cd ~/Workspace/new-machine
cp .emacs ~
cp .zshrc ~
```
* Install [ZSH](https://ohmyz.sh/)
* Install consolas font:
```
open ~/Workspace/new-machine/Consolas.ttf
```
* Set tracking speed, key repeat (fastest), and key delay (shortest)
* Copy OSX App Shortcuts (requires restart):
```
cd ~/Workspace/new-machine
cp ./GlobalPreferences.plist ~/Library/Preferences/.GlobalPreferences.plist
sudo shutdown -r now
```
* Install [iTerm2](https://iterm2.com/), and additionally set:
  * Load `iTerm_default.json` profile settings
  * `Keys` > `Remap Modifiers` > `Left Command ⌘` to `Left Control ⌃`
  * `Keys` > `Remap Modifiers` > `Right Command ⌘` to `Left Option ⌥`
  * `General` > `Selection` > `Applications in terminal may access clipboard`
* Set default Git profile:
```
git config --global user.name "Alex McNamara"
git config --global user.email "alex.mcnamara@gmail.com"
```
* Setup a GitHub [SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) key, and [GPG](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account) signing key:
```
git config --global commit.gpgsign true
git config --global tag.gpgSign true
```
```
gpg --list-secret-keys --keyid-format=long
```
```
git config --global user.signingkey <key-id>
```
* Clean up this repo and check for system software updates:
```
rm -rf ~/Workspace/new-machine
cd ~
softwareupdate -l
```