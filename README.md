<div align="center">

# 🏔️ dotfiles

**Meu Arch Linux, versionado e reproduzível.**
Um sistema novo, do zero, do jeito que eu gosto, em poucos comandos.

<br>

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=archlinux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-58E1FF?style=for-the-badge&logo=hyprland&logoColor=black)
![Vivaldi](https://img.shields.io/badge/Vivaldi-EF3939?style=for-the-badge&logo=vivaldi&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)

</div>

---

## ✨ O que é isso

Este repositório não é uma cópia do sistema. É a **receita** para recriá-lo:

- 📦 lista de todos os pacotes (oficiais e AUR)
- 🎨 configurações dos programas (`~/.config`) e do shell
- 🖼️ wallpapers, fontes e temas
- ⚙️ configs de sistema alteradas em `/etc`
- 🔧 serviços do systemd habilitados
- 🤖 scripts que automatizam o backup e a restauração

Downloads, documentos, fotos, chaves e senhas **ficam de fora de propósito**.

<!--
## 📸 Preview

![preview](arch-setup/screenshot.png)
-->

## 🗂️ Estrutura

| Caminho | O que tem |
| --- | --- |
| `.config/` | Configurações dos programas (WM, barra, terminal, launcher...) |
| `.bashrc`, `.gitconfig`, ... | Configs do shell e do Git |
| `.gitignore` | Barreira contra segredos e dados pessoais |
| `arch-setup/packages/` | Listas de pacotes e serviços |
| `arch-setup/etc/` | Cópias dos arquivos de `/etc` que eu alterei |
| `arch-setup/wallpapers/` | Meus wallpapers |
| `arch-setup/backup.sh` | Atualiza as listas e envia tudo para o GitHub |
| `arch-setup/install.sh` | Reconstrói o sistema em um Arch novo |

## 🧩 Como funciona

Os dotfiles usam um **repositório bare**: o Git guarda o histórico em `~/.dotfiles` e trata o `$HOME` como área de trabalho. Assim não precisa de symlinks nem de copiar arquivos de um lado para o outro.

Um alias facilita o uso no dia a dia:

```bash
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Com ele, `dot status`, `dot add`, `dot commit` e `dot push` funcionam como o Git normal.

## 🚀 Restaurando num Arch novo

**1. Instale o Arch** (o `archinstall` resolve) e crie um usuário com `sudo`.

**2. Instale o básico e configure o acesso ao GitHub**

```bash
sudo pacman -S --needed git openssh
ssh-keygen -t ed25519
cat ~/.ssh/id_ed25519.pub
```

Cadastre a chave em **GitHub → Settings → SSH and GPG keys**.

**3. Traga os dotfiles**

```bash
git clone --bare git@github.com:DebatingAlpaca/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout -f
git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
```

**4. Rode a instalação e reinicie**

```bash
bash ~/arch-setup/install.sh
reboot
```

O `install.sh` restaura as configs de `/etc`, instala o `yay`, todos os pacotes, gera locales e initramfs, copia os wallpapers e habilita os serviços.

## 🔄 Mantendo atualizado

Sempre que eu mudar uma config, instalar programas ou trocar wallpapers:

```bash
~/arch-setup/backup.sh
```

O script atualiza as listas, mostra tudo que vai entrar no commit e **pergunta antes de enviar**.

## 🔐 O que fica de fora

- `~/.ssh`, `~/.gnupg` e qualquer chave ou token
- Perfis de navegador (cookies, senhas, histórico)
- Dados de apps com login (Discord, Slack, etc.)
- `Downloads`, `Documents`, `Pictures`, `Videos`, `Music`
- Caches

> **Vivaldi:** o programa vem da lista de pacotes. Favoritos, extensões e ajustes voltam pelo **Vivaldi Sync**, entrando na conta dentro do navegador.

## ⚠️ Limitações

- Particionamento, bootloader e `fstab` dependem do disco e são refeitos na instalação.
- Em hardware diferente, vale revisar `arch-setup/packages/pacman.txt` (drivers de vídeo, microcode do processador, etc.) antes de rodar o `install.sh`.

## 🧰 Setup

| | |
| --- | --- |
| **Sistema** | Arch Linux |
| **Window manager** | Hyprland |
| **Barra** | Waybar |
| **Navegador** | Vivaldi |
| **Shell** | Bash |

---

<div align="center">

Feito com 🦙 e muito `pacman -S`

</div>
