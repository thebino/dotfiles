# Rustic
fast, encrypted, and deduplicated backups

See docs: [https://rustic.cli.rs](rustic.cli.rs) 

create a new backup
```shell
rustic backup
```

copy the backup to target
```shell
rustic copy
```

List snapshots
```shell
rustic snapshots
| 59985c3a | 2025-01-01 13:37:00 | Device.local    |       |      | /Users/user/Desktop                        | 217222 | 47883 |  53.5 GiB |
```

Restore a specific path
```shell
rustic restore 59985c3a:/Users/user/Desktop/path/to/folder /tmp/restore
```

