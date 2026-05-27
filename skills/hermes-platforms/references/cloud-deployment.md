# Cloud Platform Deployment Reference

Deployment guides for cloud platforms.

## AWS EC2

```bash
# SSH into instance
ssh -i key.pem ubuntu@instance

# Install Hermes
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

# Run gateway
hermes gateway install  # as systemd service
hermes gateway start
```

## DigitalOcean Droplet

Same as AWS EC2. Use Ubuntu image.

## Railway

```bash
# Set environment variables in Railway dashboard
ANTHROPIC_API_KEY=sk-...
OPENROUTER_API_KEY=sk-or-...

# Start command
hermes gateway run
```

## Fly.io

```bash
fly launch
fly secrets set ANTHROPIC_API_KEY=sk-...
fly deploy

# Verify
fly logs
```

## Resource Planning

| Use Case | CPU | RAM | Disk |
|----------|-----|-----|------|
| Chat only | 1 core | 1 GB | 5 GB |
| With tools | 2 cores | 2 GB | 10 GB |
| Heavy coding | 4 cores | 4 GB | 20 GB |
| Docker container | 2 cores | 2 GB | 10 GB |