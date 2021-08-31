# Usage:
# docker run -it --rm -v `pwd`:/work -w /work u1and0/rust

FROM u1and0/zplug:latest

RUN sudo pacman -Sy --noconfirm archlinux-keyring &&\
    sudo pacman -Syu --noconfirm &&\
    : "Discard cache" &&\
    pacman -Qtdq | xargs -r sudo pacman --noconfirm -Rcns


# Install Rust
RUN : "Setup Rust" &&\
    curl -sSf https://sh.rustup.rs | sh -s -- -y
# ENV PATH="${HOME}/.cargo/bin:$PATH"
# WORKDIR ${HOME}/.cargo

RUN export PATH="${HOME}/.cargo/bin:$PATH" &&\
    : "Setup Rust nightly version" &&\
    rustup update nightly &&\
    : "Install racer-src" &&\
    cargo +nightly install racer
RUN export PATH="${HOME}/.cargo/bin:$PATH" &&\
    : "Install Rust Language Server" &&\
    rustup component add rls \
                         rust-analysis \
                         rust-src &&\
    : "Install racer-src" &&\
    rustup default nightly &&\
    cargo install cargo-edit
#RUN :"Install rust-doc" &&\
    # curl -fsSL https://static.rust-lang.org/dist/rust-1.0.0-i686-unknown-linux-gnu.tar.gz | tar -xz

ARG LOUSER=u1and0
USER ${LOUSER}
WORKDIR /home/${LOUSER}

LABEL maintainer="u1and0 <e01.ando60@gmail.com>"\
      description="rust lang env with neovim"\
      version="rust:v0.2.0"
