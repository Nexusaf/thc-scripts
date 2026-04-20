#!/usr/bin/zsh

# THC Automation: Scheduled Cron Task
# Designed to be run automatically by the system periodically (e.g., hourly)

LOG_FILE="/thc/vault/system_health.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Capture core metrics
MEM_FREE=$(free -m | awk 'NR==2{print $4"MB"}')
UPTIME=$(uptime -p | sed 's/up //')
LOAD=$(cat /proc/loadavg | awk '{print $1}')

# Log into the vault securely
echo "[${TIMESTAMP}] AUTO-HEALTH-CHECK -> Uptime: ${UPTIME} | Free Mem: ${MEM_FREE} | Load: ${LOAD}" >> "${LOG_FILE}"
