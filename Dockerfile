# Usage:
# docker run -it --rm -v `pwd`:/work -w /work u1and0/rust

FROM u1and0/zplug:latest

# Install Rust
RUN : "Setup Rust" &&\
    curl -sSf https://sh.rustup.rs | sh -s -- -y

RUN source ${HOME}/.cargo/env &&\
    : "Setup Rust nightly version" &&\
    rustup toolchain install nightly-2021-06-07 &&\
    rustup default nightly-2021-06-07
RUN source ${HOME}/.cargo/env &&\
    : "Install racer-src" &&\
    cargo install racer
RUN source ${HOME}/.cargo/env &&\
    : "Install Rust Language Server" &&\
    rustup component add rust-analysis \
                         rust-src
# rls install tips [Nightly Rustにおいて、RLSがrustupコマンドでインストールできない時に代わりに探してくれるツール(cargo-rls-install)を作った](https://qiita.com/s4i/items/0538f7fe4874980ccf27)
RUN source ${HOME}/.cargo/env &&\
    : "Install rls Rust Language Server" &&\
    cargo install cargo-rls-install \
                  cargo-edit &&\
    cargo rls-install -y
#RUN :"Install rust-doc" &&\
    # curl -fsSL https://static.rust-lang.org/dist/rust-1.0.0-i686-unknown-linux-gnu.tar.gz | tar -xz

LABEL maintainer="u1and0 <e01.ando60@gmail.com>"\
      description="rust lang env with neovim"\
      version="rust:v1.0.0"
