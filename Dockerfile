FROM joelazar/wtfd:latest

RUN sudo -u aur yay -Sy --noconfirm \
    go \
    rust \
    npm \
    gopls \
    pyright \
    gofumpt \
    texlab \
    lua-language-server \
    yaml-language-server \
    bash-language-server \
    clang \
    rust-analyzer \
    dockerfile-language-server-bin \
    efm-langserver \
    shellcheck \
    shfmt \
    python-black \
    python-isort \
    prettier \
    eslint \
    lua-format \
    && pacman -Qtdq | xargs -r pacman --noconfirm -Rcns \
    && rm -rf /home/aur/.cache /var/cache

RUN npm i -g vscode-langservers-extracted typescript-language-server
