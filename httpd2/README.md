# httpd2

[Cliff Biffle's](https://cliffle.com/) [httpd2](https://codeberg.org/cliffle/httpd2) is a "modern static file server" with the philosophy of being simple, secure and low resource usage which makes it perfect for its use on a solar powered webserver.

It is fashioned after [djb](https://cr.yp.to/) `publicfile`. A comparison between `httpd2` vs `publicfile` can be [found here](https://codeberg.org/cliffle/httpd2/src/branch/main/doc/vs.md).

[**Repo @ Codeberg**](https://codeberg.org/cliffle/httpd2)  
[**Manual**](https://codeberg.org/cliffle/httpd2/src/branch/main/doc/manual.md)  

## Build Development Environment Setup

A spare A20-OLinuXino-LIME2 running the same OS as the server is used as development machine. 

On Armbian Debian 13 (Trixie) Minimal:

Install the necessary build dependencies for Rust and dev tools:
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl build-essential pkg-config libssl-dev vim git -y
```

Install Rust via `rustup`:  
`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

Apply environment variable for terminal to recognize Rust commands in bash:  
`source "$HOME/.cargo/env"`

Verify sucessful install:
```
rustc --version
cargo --version
```

Add 32-bit ARM hardware-float target to Rust toolchain (not really necessary since we are already running this architecture on the native host and it should add it when installing via `rustup`):  
`rustup target add armv7-unknown-linux-gnueabihf`

Install the ARM GNU C cross-compiler linker:  
`sudo apt-get install gcc-arm-linux-gnueabihf`

## Building (--target armv7-unknown-linux-gnueabihf)

> [!NOTE]
> Attempts were made to build to the `--target armv7-unknown-linux-gnueabihf` on a non-arm computer, however none were successful (though I didn't try very hard to solve `rustls` compile errors).

Clone `httpd2`:
```
git clone https://codeberg.org/cliffle/httpd2.git
cd httpd2
```

Append to `Config.toml` to map the target to installed linker:
```
[target.armv7-unknown-linux-gnueabihf]
linker = "arm-linux-gnueabihf-gcc"
```

**Standard Build (fully static program with NO system dependencies)**:
`cargo build --target=armv7-unknown-linux-gnueabihf --release`

**`journald` Support Build** (Config.toml includes journald feature, might do this by default):
`PKG_CONFIG_ALLOW_CROSS=1 cargo build --release --features journald --target=armv7-unknown-linux-gnueabihf`

> [!WARNING]
> Initial httpd2 compile time on the A20-OLinuXino-LIME2 can take upwards of **70 minutes!**

## Pre-compiled armv7-unknown-linux-gnueabihf Binaries

Found in the [**/bin** directory](bin/)

> [!NOTE]
> `/bin` contains binaries stored on **Git LFS**. See [git-lfs.com](https://git-lfs.com/) & [GitHub Installing LFS](https://docs.github.com/en/repositories/working-with-files/managing-large-files/installing-git-large-file-storage).

## Deploying
TBD

## Configuration

As per the [httpd2 manual](https://codeberg.org/cliffle/httpd2/src/branch/main/doc/manual.md):

**Run in Development**:
`cargo run path_to_web_pages`
`path_to_web_pages` is a path (absolute or relative) to web pages to serve. Server defaults to port `8000`.

**Minimal secure configuration example**:
```
httpd2 -c -U 65534 -G 65534 \
    -k /etc/letsencrypt/config/live/yoursite.com/privkey.pem \
    -r /etc/letsencrypt/config/live/yoursite.com/fullchain.pem \
    /your/site/content/directory
```

### Production Server Configuration under systemd

`systemd` [service file](httpd2.service) copied to `/etc/systemd/system/httpd2.service` on the server.

[environment configuration file](httpd2.env) copied to `/etc/default/httpd2` on the server.

See [httpd2 manual section](https://codeberg.org/cliffle/httpd2/src/branch/main/doc/manual.md#configuring-httpd2-to-run-under-systemd) for more details on options.
