# Platform Service Configuration

Systemd/LaunchD service configurations for auto-start on each platform.

## Linux (systemd)

```bash
# Systemd service for auto-start
sudo cat > /etc/systemd/system/hermes.service <<EOF
[Unit]
Description=Hermes Agent
After=network.target

[Service]
Type=simple
User=$USER
ExecStart=/usr/local/bin/hermes gateway run
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable hermes
sudo systemctl start hermes
```

### Fedora / RHEL

Same as Ubuntu, systemd works identically.

### Arch Linux

```bash
# Install Node.js
sudo pacman -S nodejs npm

# Install Hermes
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

## macOS (LaunchAgent)

```xml
~/Library/LaunchAgents/com.hermes.agent.plist:
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.hermes.agent</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/local/bin/hermes</string>
    <string>gateway</string>
    <string>run</string>
  </array>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
</dict>
</plist>
```

## Windows (WSL2)

### Performance Tips

- Use WSL2, not WSL1
- Store config in WSL home, not Windows filesystem
- Use Windows Terminal for better Unicode support

### Known Issues

- Voice features may not work
- Some terminal features limited