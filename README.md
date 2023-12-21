# dotfiles

The files in this repositories are dotfiles and Manifest files managed by [comtrya](https://github.com/comtrya/comtrya).
Comtrya allows to configure and provision the system with these files.


## Usage
[Install](https://www.comtrya.dev/getting-started/installation) comtrya.
```shell
curl -fsSL https://get.comtrya.dev | sh
```

🚨 Due to an issue [#337](https://github.com/comtrya/comtrya/issues/337) a manual installation might be needed!
## Manual installation
Install [rustup](https://rustup.rs/)
```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Clone & build comtrya
```shell
git clone https://github.com/comtrya/comtrya.git
cargo build --release
./target/release/comtrya
```


## ⚠️ Side-effects
`{{ user.config_dir }}` on Mac is refering to `~/Library/Application Support/<appname>/` it might be necessary to use `{{ user.home_dir }}/.config` instead for some apps.


## Provisioning
Provisioning **all** from repository
```shell
comtrya -d https://github.com/thebino/dotfiles apply
```

Provisioning a specific manifest or a subset
```shell
comtrya -d https://github.com/thebino/dotfiles apply -m apps.git
```
