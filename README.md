### New machine checklist

* Create a workspace:
```
mydir ~/Workspace
cd ~/Workspace
```
* Install [brew](https://brew.sh/), pull down this repo (obviously), and load default set of software:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
```
brew install git
git clone git@github.com:amcnamara/new-machine.git ~/Workspace/new-machine
```
```
cd ~/Workspace/new-machine
xargs brew install < brew-all.txt
```
* Start Ollama daemon, this also registers a system-startup initializer:
```
brew services start ollama
```
* Pull down local models for Ellama:
```
ollama pull llama3.1:8b-instruct-q8_0
ollama pull qwen2.5-coder:3b
ollama pull qwen2.5:3b
```
* Install [OMZ](https://ohmyz.sh/)
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
* Copy dotfiles to home:
```
cd ~/Workspace/new-machine
cp .emacs ~
cp .zshrc ~
```
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
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
```
```
gpg --armor --export <key-id>
```
```
git config --global user.signingkey <key-id>
```
```
ssh-keygen -t ed25519 -C "alex.mcnamara@gmail.com"
eval "$(ssh-agent -s)"
touch ~/.ssh/config
cat >> ~/.ssh/config<< EOF
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```
```
cat .ssh/id_ed25519.pub
```
* Clean up this repo and check for system software updates:
```
rm -rf ~/Workspace/new-machine
cd ~
softwareupdate -l
```