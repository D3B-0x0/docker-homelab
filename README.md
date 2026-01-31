
# Docker Homelab Stack

Clean, reproducible Docker Compose setup for self-hosting core services.

## Services

### AdGuard Home

Path:

```
adguard-home/
```

### Immich

Path:

```
immich-app/
```

## Usage

Clone the repo:

```
git clone git@github.com:D3B-0x0/docker-homelab.git
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

