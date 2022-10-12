# Dockerfile for base

# I will use fedora cause dnf has updated packages of neovim and nodejs
FROM fedora:latest
# Set image locale.
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en


# Update dnf packages
RUN dnf makecache
RUN dnf -y update

# Install dependencies
# -git
# -python3
# -pip
# -nodejs
# -npm
# -neovim
RUN dnf -y install git python3 python3-pip nodejs npm neovim gcc gcc-c++

# Install pynvim
RUN pip3 install pyvim

# Install neovim for npm
RUN npm i -g  neovim

# Install Plug
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Copy Neovim configuration files.
COPY ./config/ /root/.config/nvim/

# Install Neovim extensions.
RUN nvim --headless +PlugInstall +qall

# Create directory for Neovim COC extensions.
RUN mkdir -p /root/.config/coc/extensions

# Install Neovim COC extensions.
RUN cd /root/.config/coc/extensions && npm install $COC --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

# Avoid container exit
ENTRYPOINT ["tail", "-f", "/dev/null"]
