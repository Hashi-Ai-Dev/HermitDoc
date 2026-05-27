# Android/Termux Performance Tuning

Performance optimization for resource-constrained Android devices.

## Performance Tuning

```bash
# Use smaller models
hermes config set model.default "google/gemini-nano"

# Reduce max turns
hermes config set agent.max_turns 30
```

## Storage

```bash
# Termux has limited storage
# Use SD card for large files
termux-setup-storage
ln -s /sdcard/hermes ~/.hermes
```

## Installation (Termux)

```bash
# Install Termux from F-Droid (not Google Play)
# Grant storage permission
termux-setup-storage

# Install Hermes
pkg update && pkg upgrade
pkg install git python nodejs
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

Note: Memory is limited on Android. Use lightweight models.