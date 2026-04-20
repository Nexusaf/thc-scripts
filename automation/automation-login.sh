#!/usr/bin/zsh

# THC Automation: Login Trigger
# Executed every time a user logs into the system.

LOG_FILE="/thc/vault/login_history.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
USER=$(whoami)
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')

# 1. Log the login event silently
echo "[${TIMESTAMP}] User '${USER}' logged in. Root disk at ${DISK_USAGE} capacity." >> "${LOG_FILE}"

# 2. Display an autonomous warning if disk is above 80%
DISK_NUM=$(echo $DISK_USAGE | tr -d '%')
if [ "$DISK_NUM" -ge 80 ]; then
    echo -e "\n\e[1;31m[!] THC AUTOMATION ALERT: Disk usage is critically high (${DISK_USAGE}). Consider accessing /thc/vault to clean up.\e[0m\n"
fi
