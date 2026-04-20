#!/usr/bin/zsh

# THC-OS: Instalador do Boot Experience (Block 05)
# Execute como: sudo zsh thc-install-boot.sh

GREEN='\e[1;32m'
CYAN='\e[1;36m'
YELLOW='\e[1;33m'
RED='\e[1;31m'
RESET='\e[0m'

log()  { echo -e "${CYAN}[THC]${RESET} $1" }
ok()   { echo -e "${GREEN}[OK]${RESET}  $1" }
warn() { echo -e "${YELLOW}[!]${RESET}   $1" }
err()  { echo -e "${RED}[ERR]${RESET} $1" }

echo ""
echo -e "${GREEN}  ╔══════════════════════════════════════╗${RESET}"
echo -e "${GREEN}  ║   THC-OS  BOOT EXPERIENCE INSTALLER  ║${RESET}"
echo -e "${GREEN}  ╚══════════════════════════════════════╝${RESET}"
echo ""

# ── Passo 1: GRUB ────────────────────────────────────────────
log "Configurando GRUB..."

GRUB_FILE="/etc/default/grub"

# Renomeia a entrada padrão para THC-OS
sudo sed -i 's/GRUB_DISTRIBUTOR=.*/GRUB_DISTRIBUTOR="THC-OS"/' "$GRUB_FILE"

# Ativa modo silencioso total
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=3 udev.log_priority=3 vt.global_cursor_default=0 splash"/' "$GRUB_FILE"

# Aplica tema THC se existir
if [ -d "/boot/grub/themes/thc" ]; then
    sudo sed -i 's/#GRUB_THEME=.*/GRUB_THEME="\/boot\/grub\/themes\/thc\/theme.txt"/' "$GRUB_FILE"
    ok "Tema GRUB THC aplicado."
else
    warn "Pasta do tema GRUB não encontrada. Execute o passo de instalação do tema primeiro."
fi

sudo grub-mkconfig -o /boot/grub/grub.cfg
ok "GRUB reconfigurado com identidade THC-OS."

# ── Passo 2: Plymouth ────────────────────────────────────────
log "Instalando Plymouth..."

# Verifica se yay está disponível
if ! command -v yay &>/dev/null; then
    warn "yay não encontrado. Instalando..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    ok "yay instalado."
fi

yay -S --noconfirm plymouth
ok "Plymouth instalado."

# ── Passo 3: Tema THC ────────────────────────────────────────
log "Instalando tema THC-OS no Plymouth..."

THEME_DIR="/usr/share/plymouth/themes/thc-os"
sudo mkdir -p "$THEME_DIR"

# Copia os arquivos do tema do repositório
sudo cp /thc/scripts/vm/plymouth/thc-os.plymouth "$THEME_DIR/"
sudo cp /thc/scripts/vm/plymouth/thc-os.script   "$THEME_DIR/"

# Define o tema ativo
sudo plymouth-set-default-theme -R thc-os
ok "Tema THC-OS definido como padrão do Plymouth."

# ── Passo 4: Hook no mkinitcpio ──────────────────────────────
log "Injetando Plymouth no ramdisk do kernel..."

# Adiciona o hook 'plymouth' ao mkinitcpio.conf se ainda nao existir
if ! grep -q "plymouth" /etc/mkinitcpio.conf; then
    sudo sed -i 's/HOOKS=(base udev/HOOKS=(base udev plymouth/' /etc/mkinitcpio.conf
    ok "Hook Plymouth injetado no mkinitcpio."
else
    warn "Hook Plymouth já presente. Pulando."
fi

sudo mkinitcpio -P
ok "Ramdisk do kernel reconstruído com Plymouth."

# ── Finalização ──────────────────────────────────────────────
echo ""
echo -e "${GREEN}  ╔══════════════════════════════════════╗${RESET}"
echo -e "${GREEN}  ║     BOOT EXPERIENCE INSTALADO!       ║${RESET}"
echo -e "${GREEN}  ║   Execute: sudo reboot para testar   ║${RESET}"
echo -e "${GREEN}  ╚══════════════════════════════════════╝${RESET}"
echo ""
