# Docker Deployment Reference

Complete Docker deployment options.

## Run Interactively

```bash
docker run -it \
  -v ~/.hermes:/root/.hermes \
  -v $(pwd):/workspace \
  ghcr.io/nousresearch/hermes-agent
```

## Run with Custom Config

```bash
docker run -d \
  --name hermes \
  -v ~/.hermes:/root/.hermes \
  -v /path/to/config:/root/.hermes/config.yaml \
  -p 18789:18789 \
  ghcr.io/nousresearch/hermes-agent hermes gateway run
```

## Docker Compose

```yaml
version: '3.8'
services:
  hermes:
    image: ghcr.io/nousresearch/hermes-agent
    volumes:
      - ~/.hermes:/root/.hermes
    ports:
      - "18789:18789"
    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
    restart: unless-stopped
```

## Minimal Dockerfile

```dockerfile
FROM ghcr.io/nousresearch/hermes-agent
WORKDIR /workspace
CMD ["hermes", "gateway", "run"]
```

## Resource Limits

```bash
docker run -d \
  --name hermes \
  --memory="2g" \
  --cpus="1.0" \
  -v ~/.hermes:/root/.hermes \
  ghcr.io/nousresearch/hermes-agent
```