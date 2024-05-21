# dotfiles

The files in this repositories are dotfiles and Manifest files managed by [comtrya](https://github.com/comtrya/comtrya).
Comtrya allows to configure and provision the system with these files.


## Installation
To install [comtrya](https://www.comtrya.dev/getting-started/installation) run the installation script or download it from their page.
```shell
curl -fsSL https://get.comtrya.dev | sh
```

#### Manual installation
🚨 Due to an issue [#337](https://github.com/comtrya/comtrya/issues/337) a manual installation might be needed!

```shell
git clone https://github.com/comtrya/comtrya.git
cargo build --release
./target/release/comtrya
```


## ⚠️ Side-effects
`{{ user.config_dir }}` on Mac is refering to `~/Library/Application Support/<appname>/` it might be necessary to use `{{ user.home_dir }}/.config` for some apps instead.


## Provisioning
Provisioning **all** from repository
```shell
comtrya -d https://github.com/thebino/dotfiles apply
```

Provisioning a specific manifest or a subset
```shell
comtrya -d https://github.com/thebino/dotfiles apply -m apps.git
```


## Encryption
Some configuration files are encrypted using GPG and are decrypted by comtrya during the provisioning.

Encryption
```shell
$ gpg --output input.gpg --encrypt --armor input.txt
```

Decryption
```shell
$ gpg --output output.txt --decrypt input.gpg
```


# Editor
To have the same look from NeoVim in Helix was a difference of 1.000 less lines of configurations.

```
nvim: 1187 loc configuration
hx: 87 loc configuration
```

| nvim       | helix           |
| ------------- |:-------------:|
| ![nvim screen](docs/editor_nvim.png) | ![helix screen](docs/editor_hx.png) |
