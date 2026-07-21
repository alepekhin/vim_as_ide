#
# Install missed apps
#
cd
sudo apt update
sudo apt install btop nvtop curl neovim chromium openjdk-25-jdk ripgrep git maven
sudo snap install vlc
#
# Github projects
#
mkdir -p projects/Github
cd projects/Github
git clone git@github.com:alepekhin/vim_as_ide.git
git clone git@github.com:alepekhin/jls.git
#
# Build jls
#
cd jls
mvn package -Dmaven.test.skip
cd dist
ln -s /usr/lib/jvm/java-25-openjdk-amd64 linux
#
## Install mcp server
#
cd
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH=$HOME/.local/bin:$PATH
uv tool install duckduckgo-mcp-server
#
# Configure nvim
#
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv
cp projects/Github/vim_as_ide/config/nvim ~/.config
#
# Install ollama
#
curl -fsSL https://ollama.com/install.sh | sh
ollama run carstenuhlig/omnicoder-2-9b:latest 
#
# Install opencode
#
curl -fsSL https://opencode.ai/install | bash
mkdir -p .config/opencode
copy projects/Github/vim_as_ide/config/opencode.jsonc  ~/.config/opencode/opencode.jsonc
#
echo in .bashrc:
echo set alias  `alias vi='nvim'`
echo add $HOME/.local/bin to PATH
