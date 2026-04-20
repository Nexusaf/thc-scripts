<div align="center">

```
████████╗██╗  ██╗ ██████╗      ██████╗ ███████╗
   ██╔══╝██║  ██║██╔════╝     ██╔═══██╗██╔════╝
   ██║   ███████║██║          ██║   ██║███████╗
   ██║   ██╔══██║██║          ██║   ██║╚════██║
   ██║   ██║  ██║╚██████╗     ╚██████╔╝███████║
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝      ╚═════╝ ╚══════╝
```

**A personal operating system built block by block.**  
*Minimal. Intentional. Yours.*

![Status](https://img.shields.io/badge/status-active-00ff88?style=flat-square)
![Base](https://img.shields.io/badge/base-Arch%20Linux-1793d1?style=flat-square&logo=arch-linux)
![Shell](https://img.shields.io/badge/shell-zsh-informational?style=flat-square)
![Block](https://img.shields.io/badge/current%20block-05-blueviolet?style=flat-square)

</div>

---

## What is THC-OS?

THC-OS is not a Linux distro. It is not a dotfile collection.  

It is an **operating system built from intent** — where every directory has a reason, every command has a name, and the system itself reflects its creator.

Built on Arch Linux, evolved through structured **blocks**, and deployed through its own internal toolchain.

---

## Architecture

```
/thc/
├── bin/        ← Native executables (thc-*)
├── core/       ← System core files
├── tools/      ← External utilities
├── vault/      ← Logs, backups, secure storage
└── scripts/    ← This repository (thc-scripts)
    ├── bin/          ← Command source files
    ├── vm/           ← VM-specific scripts
    ├── automation/   ← Scheduled and login hooks
    ├── docs/         ← Additional documentation
    └── clipboard/    ← Volatile sync area (git-ignored)
```

---

## Command Layer

All native THC-OS commands follow the `thc-*` convention and live in `/thc/bin/`.

| Command | Description |
|---|---|
| `thc` | Hub command — lists all available commands with live status |
| `thc-info` | System identity: OS, kernel, user, architecture |
| `thc-health` | Metrics snapshot: memory, disk, uptime, load |
| `thc-paths` | Visual map of the `/thc/` directory structure |
| `thc-motd` | Dynamic login screen with full system info panel |
| `thc-watch` | Real-time live dashboard with color-coded progress bars |
| `thc-sync` | Deployment pipeline: pull from GitHub → deploy to `/thc/bin/` |
| `thc-ghost` | Stealth mode: controlled wipe of logs and terminal history |
| `thc-autologin` | Login automation hook: vault logging + disk health check |

---

## Development Workflow

THC-OS uses **GitHub as a bridge** between the host machine (Windows) and the virtual machine (Arch Linux).

```
  WINDOWS                     GITHUB                      VM (THC-OS)
  ────────                   ────────                   ────────────
  Create script          →   git push               →   thc-sync
  Edit command           →   git commit + push      →   thc-sync
  Update docs            →   git push               →   git pull
```

### Deploying a new command

```bash
# 1. Create the script in /bin/ on Windows
# 2. Commit and push to GitHub
# 3. Inside the VM:
thc-sync
# Done. The command is live.
```

`thc-sync` handles: `git pull` → diff → `cp` → `chmod +x` → `dos2unix` → vault log.

---

## Block Progress

| Block | Name | Status |
|:---:|---|:---:|
| 01 | Base System Initialization | ✅ |
| 02 | THC Identity Layer | ✅ |
| 03 | THC Command Layer | ✅ |
| 04 | THC Automation Layer | ✅ |
| 05 | THC Boot Experience | ✅ |
| 06 | Vault Security Layer | 🔜 |
| 07 | Desktop Environment | 🔜 |
| 08 | THC Package Manager | 🔜 |
| 09 | ISO Generation | 🔜 |

---

## Boot Sequence

```
[ POWER ON ]
     │
     ▼
[ GRUB ]  →  "THC-OS"  (1s timeout, silent)
     │
     ▼
[ KERNEL ]  →  quiet loglevel=3  (no text output)
     │
     ▼
[ /etc/issue ]  →  THC-OS ASCII identity screen
     │
     ▼
[ LOGIN ]  →  thc-core login: _
     │
     ▼
[ ~/.zshrc ]  →  thc-motd  →  thc-autologin
     │
     ▼
[ READY ]  →  /thc/core is waiting.
```

---

## Vault

The `/thc/vault/` directory is the system's persistent memory.

| File | Contents |
|---|---|
| `login_history.log` | Timestamp, user, disk usage on every login |
| `system_health.log` | Hourly: CPU load, free memory, uptime (via cron) |
| `sync_history.log` | Every `thc-sync` execution log |

---

## Philosophy

> *THC OS is not just a system configuration.*
>
> *It is an evolving environment where tools are intentional,*  
> *structure is meaningful,*  
> *and the system reflects its creator.*

---

<div align="center">
<sub>Built on Arch. Owned by design.</sub>
</div>
