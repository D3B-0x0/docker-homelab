
# Docker Homelab Stack

Clean, reproducible Docker Compose setup for self-hosting core services.

## Services

### AdGuard Home

* Network-wide DNS blocking
* Runs close to the network for low latency
* Tailscale support for remote access

Path:

```
adguard-home/
```

### Immich

* Self-hosted photo & video backup
* Hardware acceleration configs included (ML + transcoding)
* Designed to run behind Docker with GPU passthrough

Path:

```
immich-app/
```

## Requirements

* Linux host
* Docker
* Docker Compose v2
* (Optional) GPU + proper drivers for Immich HW accel

## Usage

Clone the repo:

```
git clone <repo-url>
cd docker
```

Create env files:

```
cp adguard-home/.env.example adguard-home/.env
cp immich-app/.env.example immich-app/.env
```

Edit the `.env` files with your own values.

Start services:

```
docker compose up -d
```

## Notes

* Runtime data, databases, and secrets are **intentionally excluded as I use them in my homelab aswell**
* Anything ignored by `.gitignore` is expected to be created at runtime
* This repo is meant to be **readable, auditable, and forkable**

## License

Do whatever you want. Just don’t be stupid with secrets.

