# dotfiles

The files in this repositories are dotfiles and Manifest files managed by [comtrya](https://github.com/comtrya/comtrya).
Comtrya allows to configure and provision the system with these files.


## Usage
[Install](https://www.comtrya.dev/getting-started/installation) comtrya.
```shell
curl -fsSL https://get.comtrya.dev | sh
```

Provisioning **all**
```shell
comtrya -d https://github.com/thebino/dotfiles apply
```

Provisioning a specific manifest or a subset
```shell
comtrya -d https://github.com/thebino/dotfiles apply -m apps.git
```


## Manual installation
Clone comtrya project
```shell
git clone https://github.com/comtrya/comtrya.git
```

Install [rustup](https://rustup.rs/)
```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Build and run comtrya
```shell
cd comtrya
~/.cargo/bin/cargo run --bin comtrya --
```
