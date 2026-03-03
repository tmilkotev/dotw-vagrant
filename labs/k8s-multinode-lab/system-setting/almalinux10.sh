#!/usr/bin/env bash
set -e

echo "==> AlmaLinux 10 base provisioning started"

if [ "$EUID" -ne 0 ]; then
  echo "ERROR: Provision script must run as root"
  exit 1
fi

echo "==> Refreshing DNF metadata"
dnf makecache -y

echo "==> Upgrading system packages"
dnf upgrade -y

echo "==> Installing base packages"
dnf install -y \
  bash-completion \
  curl \
  wget \
  vim \
  nano \
  git \
  net-tools \
  bind-utils \
  iproute \
  iputils \
  lsof \
  tar \
  unzip \
  rsync \
  ca-certificates \
  dnf-plugins-core

echo "==> Ensuring SSH service is enabled"
systemctl enable sshd
systemctl start sshd

# ============================================================
# Configure /etc/hosts from Vagrant system-setting/hosts.entries
# ============================================================

HOSTS_SOURCE="/vagrant/system-setting/hosts.entries"
HOSTS_TARGET="/etc/hosts"
HOSTS_TMP="/tmp/hosts.vagrant.tmp"

echo "==> Configuring /etc/hosts"

if [ ! -f "$HOSTS_SOURCE" ]; then
  echo "WARNING: $HOSTS_SOURCE not found. Skipping /etc/hosts configuration."
else
  # Always rebuild clean localhost section
  {
    echo "127.0.0.1       localhost"
    echo "::1             localhost"
    echo ""
    echo "# Vagrant-managed hosts (system-setting/hosts.entries)"
  } > "$HOSTS_TMP"
  
  while read -r ip host; do
    if [ -n "$ip" ] && [ -n "$host" ]; then
      printf "%-15s %s\n" "$ip" "$host" >> "$HOSTS_TMP"
    fi
  done < "$HOSTS_SOURCE"

  mv "$HOSTS_TMP" "$HOSTS_TARGET"
  echo "==> /etc/hosts configured successfully"
fi

echo "==> Cleaning DNF cache"
dnf clean all

echo "==> AlmaLinux 10 base provisioning complete"
## ====================
# Additional provisioning steps can be added below as needed
## ====================

## --- Security relax (lab use) ---
#
## 1) Disable SELinux (effective now + persistent)
#if command -v getenforce >/dev/null 2>&1; then
#  echo "==> Disabling SELinux (runtime)"
#  setenforce 0 || true
#fi
#
#if [ -f /etc/selinux/config ]; then
#  echo "==> Disabling SELinux (persistent)"
#  sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
#fi
#
## 2) Disable firewall (firewalld) now + persistent
#if systemctl list-unit-files | grep -q '^firewalld\.service'; then
#  echo "==> Disabling firewalld"
#  systemctl disable --now firewalld || true
#  systemctl mask firewalld || true
#fi