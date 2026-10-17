#!/usr/bin/env bash
set -euo pipefail

SETUP="$HOME/arch-setup"
WALLPAPERS_SRC="$HOME/Pictures/wallpapers"

dot() { git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"; }

mkdir -p "$SETUP/packages" "$SETUP/etc" "$SETUP/wallpapers"

pacman -Qqen > "$SETUP/packages/pacman.txt"
pacman -Qqem > "$SETUP/packages/aur.txt"

systemctl list-unit-files --state=enabled --type=service,timer --no-legend | awk '{print $1}' > "$SETUP/packages/services-system.txt"
systemctl --user list-unit-files --state=enabled --type=service,timer --no-legend | awk '{print $1}' > "$SETUP/packages/services-user.txt" || true

for f in pacman.conf mkinitcpio.conf environment locale.gen locale.conf vconsole.conf; do
  if [ -f "/etc/$f" ]; then cp "/etc/$f" "$SETUP/etc/$f"; fi
done

if [ -d "$WALLPAPERS_SRC" ]; then
  cp -ru "$WALLPAPERS_SRC/." "$SETUP/wallpapers/"
fi

for p in .config .gitignore .bashrc .bash_profile .zshrc .zprofile .profile .gitconfig .xinitrc .local/bin .local/share/fonts .themes .icons arch-setup; do
  if [ -e "$HOME/$p" ]; then dot add "$HOME/$p"; fi
done
dot add -u

echo "Arquivos preparados para o commit:"
dot diff --cached --name-status
echo
read -r -p "Enviar para o GitHub? [s/N] " resp
if [ "$resp" != "s" ]; then
  echo "Cancelado. Nada foi commitado."
  exit 0
fi

dot commit -m "backup $(date +%F)" || echo "Nada novo para commitar."
dot push -u origin main
