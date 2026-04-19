#!/usr/bin/zsh

# Cores ANSI
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
MAGENTA='\e[1;35m'
CYAN='\e[1;36m'
RESET='\e[0m'
BOLD='\e[1m'

clear 

echo -e "${CYAN}"
echo "    _______ __  __ _____          ____  _____ "
echo "   /_  __// // / / ___/   ____   / __ \/ ___/ "
echo "    / /  / __  // /__    /___/  / / / /\__ \  "
echo "   /_/  /_/ /_/ \___/           \____/___/ /  "
echo "                                    /____/    "
echo -e "${RESET}"

# Coleta de dados simples para identidade do sistema (Out of scope de boot process, mas perfeito para login)
USER_NAME=$(whoami)
KERNEL_VER=$(uname -r)
UPTIME=$(uptime -p | sed 's/up //')

echo -e "${BOLD}${MAGENTA} [ ${CYAN}IDENTIDADE DO SISTEMA ESTABELECIDA ${MAGENTA}]${RESET}"
echo -e "${YELLOW} ► Usuário:${RESET} ${USER_NAME}"
echo -e "${YELLOW} ► Kernel:${RESET}  ${KERNEL_VER}"
echo -e "${YELLOW} ► Uptime:${RESET}  ${UPTIME}"
echo ""
echo -e "${GREEN} /thc/core está aguardando seus comandos.${RESET}"
echo ""
