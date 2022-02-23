#!/bin/bash

if [ ! -f "/etc/systemd/system/media-meta.mount" ]; then
  cp /media/meta/offsite-backup/extra/media-meta.mount /etc/systemd/system/media-meta.mount
  systemctl daemon-reload
  systemctl enable media-meta.mount
fi

if [ ! -f "/etc/systemd/system/vault-boot.service" ]; then
  cp /media/meta/offsite-backup/extra/vault-boot.service /etc/systemd/system/vault-boot.service
  systemctl daemon-reload
  systemctl enable vault-boot.service
  systemctl start vault-boot.service
fi


fgrep -q '/dev/mapper/vault-data' /proc/mounts && {
  if [ ! -d "/media/data/logs" ]; then
    btrfs subvolume create /media/data/logs
  fi
}
