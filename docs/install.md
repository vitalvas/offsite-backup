# Install

## Install packages

```shell
apt update -qy
apt upgrade -qy

apt install -qy xfsprogs btrfs-progs git udev cryptsetup parted
```

## Prepare disk

```shell
parted -s /dev/sda mklabel gpt
parted -s /dev/sda mkpart primary 0% 64G
parted -s /dev/sda mkpart primary 64G 100%
parted -s /dev/sda align-check optimal 1
parted -s /dev/sda align-check optimal 2
```

```shell
mkfs.xfs -L vault-meta -f /dev/sda1

mkdir -p /media/{meta,data}

chattr +i /media/meta
chattr +i /media/data
chattr +i /media
```

## Install app

```shell
systemd-mount -t xfs /dev/sda1 /media/meta/

git clone https://github.com/vitalvas/offsite-backup.git /media/meta/offsite-backup/
```
