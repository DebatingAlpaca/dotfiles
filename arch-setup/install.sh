#!/usr/bin/env bash
set -euo pipefail

SETUP="$HOME/arch-setup"

for f in pacman.conf mkinitcpio.conf environment locale.gen locale.conf vconsole.conf; do
  if [ -f "$SETUP/etc/$f" ]; then sudo cp "$SETUP/etc/$f" "/etc/$f"; fi
done

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel git

if ! command -v yay >/dev/null 2>&1; then
  tmp="$(mktemp -d)"
  git clone https://aur.archlinux.org/yay.git "$tmp/yay"
  (cd "$tmp/yay" && makepkg -si --noconfirm)
  rm -rf "$tmp"
fi

xargs -r -a "$SETUP/packages/pacman.txt" sudo pacman -S --needed --noconfirm
xargs -r -a "$SETUP/packages/aur.txt" yay -S --needed --noconfirm

sudo locale-gen
sudo mkinitcpio -P
fc-cache -f

mkdir -p "$HOME/Pictures/wallpapers"
cp -rn "$SETUP/wallpapers/." "$HOME/Pictures/wallpapers/"

while read -r unit; do
  sudo systemctl enable "$unit" || true
done < "$SETUP/packages/services-system.txt"

while read -r unit; do
  systemctl --user enable "$unit" || true
done < "$SETUP/packages/services-user.txt"

echo "Pronto. Reinicie o sistema."
