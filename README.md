### New machine checklist

* Create a workspace:
```
mkdir ~/Workspace
cd ~/Workspace
```
* Install [brew](https://brew.sh/), pull down this repo (obviously), and load default set of software:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
```
brew install git
git clone https://github.com/amcnamara/new-machine.git ~/Workspace/new-machine
```
```
cd ~/Workspace/new-machine
xargs brew install < brew-all.txt
```
* Start Emacs and Ollama daemons, this also registers a system-startup initializer:
```
brew services start emacs
brew services start ollama
```
* Pull down local models for Ollama:
```
ollama pull llama4:scout
ollama pull qwen3-coder:30b
ollama pull qwen3:4b
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
cp .gitconfig ~
touch ~/.hushlogin
```
* Configure root shell and symlink to my user's `.zshrc`:
```
sudo ln -s ~/.zshrc /var/root/.zshrc
sudo chsh -s /bin/zsh root
```
* Install ConsolasNF font:
```
open ~/Workspace/new-machine/ConsolasNF.ttf
```
* Set tracking speed, key repeat (fastest), and key delay (shortest)
* Install [Docker Desktop](https://docs.docker.com/desktop/setup/install/mac-install/)
* Copy OSX App Shortcuts (requires restart):
```
cd ~/Workspace/new-machine

defaults import -g ./global_defaults.plist
defaults import com.apple.symbolichotkeys ./symbolic_hotkeys.plist

killall cfprefsd
sudo shutdown -r now
```
* Install [Kitty](https://sw.kovidgoyal.net/kitty/) and copy in global configs:
  * Swap out the terrible icon with `Terminal.app`, and flush Dock cache
  * Click `kitty > Reload Preferences` to pull in the updated config
```
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mkdir -p ~/.config/kitty
cp ./kitty.conf ~/.config/kitty
```
* Install [Karabiner](https://karabiner-elements.pqrs.org/) and override config
  * Follow OSX permissions grant [instructions](https://karabiner-elements.pqrs.org/docs/manual/misc/required-macos-settings/)
```
brew install --cask karabiner-elements
mkdir -p ~/.config/karabiner
cp ./karabiner.json ~/.config/karabiner
```
* Install and use the most recent LTS version of Node:
```
nvm install --lts
nvm use --lts
```
* Install a recent stable version of Python via pyenv:
```
pyenv install 3.10.12
pyenv global 3.10.12
```
* Setup a GitHub [SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) key, and [GPG](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account) signing key:
  * Configure pinentry to store the signing key on the login keychain: add `use-agent` to `~/.gnupg/gpg.conf` (`~/.gnupg/gpg-agent.conf` should have a pointer to brew's installation of `pinentry-program`)
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
