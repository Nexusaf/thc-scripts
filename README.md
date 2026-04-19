# THC Scripts Repository

This repository acts as the primary logical bridge (Clipboard) between the Host infrastructure and the THC-OS Virtual Environment. It is designed to be easily cloneable and kept in sync.

## Structure Overview

- `/host`: Scripts and binaries intended to run on the Real Machine (e.g., PowerShell bridging scripts).
- `/vm`: Scripts tailored exclusively for execution inside the THC-OS VM.
- `/docs`: Additional documentation regarding workflows and system specifics.
- `/bin`: Core binaries/programs (you can symlink these into `/thc/bin` in the VM for rapid execution).
- `/clipboard`: A volatile folder for tossing text logs, snippets, or temporary data between Host and VM. (Usually ignored by Git).

## Sync Strategy

1. Maintain this repo on your GitHub/GitLab.
2. Clone it directly to `/thc/scripts` inside your Arch Linux VM:
   `git clone <your_repo_url> /thc/scripts`
3. Symlink anything you need from `/thc/scripts/bin/*` to `/thc/bin/`.
