#!/usr/bin/env bash
set -euo pipefail

# final-setup.sh
# Post-install configuration for Linux Mint 22 (Ubuntu 24.04 base)
# - Creates a user (if not present), enables SSH, Samba, Apache
# - Sets hostname, installs common packages, configures a share
# - Safe to re-run; idempotent where practical

# Defaults (you can edit these before running)
USER_NAME="student"
HOSTNAME_SET="lab-linux-autoinstall"
TIMEZONE="America/Chicago"
LOCALE="en_US.UTF-8"
SHARE_PATH="/srv/share"
APACHE_INDEX_MSG="Hello from zero-touch!"

# Helper: run apt non-interactively
export DEBIAN_FRONTEND=noninteractive

log() {
  echo "[final-setup] $1"
}

require_root() {
  if [[ $(id -u) -ne 0 ]]; then
    echo "Run this script as root (sudo)." >&2
    exit 1
  fi
}

ensure_user() {
  if id -u "$USER_NAME" >/dev/null 2>&1; then
    log "User $USER_NAME already exists."
  else
    log "Creating user $USER_NAME"
    adduser --disabled-password --gecos "" "$USER_NAME"
    # Optionally set a password (commented to prefer SSH keys)
    # echo "$USER_NAME:changeme" | chpasswd
    usermod -aG sudo "$USER_NAME"
  fi
}

set_hostname() {
  if [[ "$(hostname)" != "$HOSTNAME_SET" ]]; then
    log "Setting hostname to $HOSTNAME_SET"
    hostnamectl set-hostname "$HOSTNAME_SET"
  else
    log "Hostname already $HOSTNAME_SET"
  fi
}

set_locale_timezone() {
  log "Setting timezone to $TIMEZONE"
  timedatectl set-timezone "$TIMEZONE" || true
  log "Generating locale $LOCALE"
  locale-gen "$LOCALE" || true
}

apt_update_install() {
  log "Updating apt and installing packages"
  apt-get update -y
  apt-get install -y openssh-server samba apache2 git curl vim python3 python3-pip ufw
}

configure_ssh() {
  log "Enabling SSH"
  systemctl enable --now ssh
  # Optional: harden SSH — disable password auth (uncomment to enforce key-only)
  # sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
  # systemctl restart ssh
}

configure_ufw() {
  log "Configuring UFW"
  ufw allow OpenSSH || true
  ufw allow "Apache Full" || true
  # Optional: enable firewall
  # ufw enable
}

configure_samba() {
  log "Configuring Samba share at $SHARE_PATH"
  mkdir -p "$SHARE_PATH"
  chown -R "$USER_NAME":"$USER_NAME" "$SHARE_PATH"
  if ! grep -q "\[autoshare\]" /etc/samba/smb.conf; then
    cat >> /etc/samba/smb.conf <<EOF
[autoshare]
   path = $SHARE_PATH
   browseable = yes
   read only = no
   guest ok = yes
   create mask = 0664
   directory mask = 0775
EOF
  fi
  systemctl restart smbd || systemctl restart samba || true
}

configure_apache() {
  log "Configuring Apache index page"
  echo "<html><body><h1>$APACHE_INDEX_MSG</h1></body></html>" > /var/www/html/index.html
  systemctl enable --now apache2
}

summary() {
  log "Setup completed"
  ip addr | sed -n 's/^\s*inet\s\+\([^\s]*\)\s.*\bstate\b.*$/IP: \1/p'
  echo "Hostname: $(hostname)"
  echo "User: $USER_NAME"
  echo "Share: $SHARE_PATH"
  echo "Apache: http://$(hostname -I | awk '{print $1}')/"
}

main() {
  require_root
  ensure_user
  set_hostname
  set_locale_timezone
  apt_update_install
  configure_ssh
  configure_ufw
  configure_samba
  configure_apache
  summary
}

main "$@"
