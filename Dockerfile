# Dockerfile for base

# I will use fedora cause dnf has updated packages of neovim and nodejs
FROM fedora:latest

# Update dnf packages
RUN dnf makecache
RUN dnf -y update


# Avoid container exit
ENTRYPOINT ["tail", "-f", "/dev/null"]
