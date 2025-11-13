# itec-1475 other software managers - one-file pack (due 2025-10-05)

plain, short answers; minimal screenshots; one paste-once block per tool. use debian/ubuntu.

## quick install (once)
```bash
sudo apt update
sudo apt install -y snapd flatpak gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## apt demo
```bash
sudo apt install -y htop && htop --version | head -n 1
sudo apt remove -y htop && ! command -v htop && echo "apt demo done"
```

## snap demo
```bash
sudo snap install btop
btop --version || snap info btop | head -n 8
sudo snap remove btop
```

## flatpak demo
```bash
flatpak install -y flathub com.obsproject.Studio
flatpak info com.obsproject.Studio | head -n 12
flatpak uninstall -y --delete-data com.obsproject.Studio
```

## tarball demo (no package manager)
```bash
cd /tmp
curl -L -o jq.tar.gz https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64.tar.gz
mkdir -p jq-demo && tar -xzf jq.tar.gz -C jq-demo --strip-components=0 || true
# simulate: move binary into /usr/local/bin
sudo curl -L -o /usr/local/bin/jq https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64
sudo chmod +x /usr/local/bin/jq
jq --version
sudo rm -f /usr/local/bin/jq
```

## short answers (paste into submission)
- apt: uses distro repos; integrates with dpkg; easy updates
- snap: sandboxed apps; auto-updates; larger disk use
- flatpak: cross-distro; per-app runtimes; flathub catalog
- tarball: manual; fastest control; no auto-updates

## screenshots to include (keep ui private)
- apt: version line from htop or any cli output
- snap: `snap info btop` top lines or btop version
- flatpak: `flatpak info` top lines
- tarball: `jq --version`
