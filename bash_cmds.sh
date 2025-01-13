#!/bin/zsh

# Function to Install NVIM config into runnign docker container
function install_nvim_in_ubuntu_arm64_container() {
    if [ -z "$1" ]; then
        echo "Usage: install_nvim_in_ubuntu_container <container>"
        return 1
    fi
    container=$1
    # Copy over Local Config Files
    docker exec -it ${container} bash -c 'mkdir -p ~/.config'
    docker cp ~/.config/nvim $container:/root/.config/
    docker cp ~/.config/ruff $container:/root/.config/
    # Commands to Installl Components into container
    docker exec -it ${container} bash -c 'apt update && apt install -y wget curl unzip make software-properties-common liblua5.1-0-dev lua5.1 git'
    docker exec -it ${container} bash -c 'add-apt-repository ppa:deadsnakes/ppa'
    docker exec -it ${container} bash -c 'apt update && apt install -y python3.9 python3.9-venv python3.9-dev'
    
    # Cmd to Install Go
    docker exec -it ${container} bash -c 'cd /opt && wget https://go.dev/dl/go1.23.4.linux-arm64.tar.gz && tar -C /usr/local -xzf go1.23.4.linux-arm64.tar.gz '
    # Cmd to Install NVM
    docker exec -it ${container} bash -c 'curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
    # Cmd to Install Lua Rocks
    docker exec -it ${container} bash -c 'cd /opt && wget https://luarocks.github.io/luarocks/releases/luarocks-3.11.0.tar.gz && tar -xzvf luarocks-3.11.0.tar.gz && cd luarocks-3.11.0 && ./configure --with-lua-include=/usr/include && make && make install'

    # Configure Path
    docker exec -it ${container} bash -c 'echo "export PATH=/usr/local/go/bin:/opt/nvim/build/bin:$PATH" >> ~/.bashrc'
    
    # Cmd to Install NVM
    docker exec -it ${container} bash -c "source ~/.bashrc && nvm install --lts && ln -s /root/.nvm/versions/node/v22.13.0/bin/node /usr/bin/node"

    # Cmd to Install NVIM
    docker exec -it ${container} bash -c "apt install -y ninja-build gettext cmake curl build-essential"
    docker exec -it ${container} bash -c "cd /opt && wget https://github.com/neovim/neovim/archive/refs/tags/v0.10.3.tar.gz && tar -xzf v0.10.3.tar.gz && mv neovim-0.10.3 nvim"
    docker exec -it ${container} bash -c "cd /opt/nvim && nvm install --lts && make CMAKE_BUILD_TYPE=RelWithDebInfo && make install"

 }
