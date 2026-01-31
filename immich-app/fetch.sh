#!/usr/bin/env bash
set -euo pipefail

# Files to possibly fetch (target filenames)
COMPOSE_FILE="docker-compose.yml"
HWACCEL_TRANSCODE="hwaccel.transcoding.yml"
HWACCEL_ML="hwaccel.ml.yml"

# Hardcoded URLs (no prompting for URLs)
COMPOSE_URL="https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml"
HWACCEL_TRANSCODE_URL="https://github.com/immich-app/immich/releases/latest/download/hwaccel.transcoding.yml"
HWACCEL_ML_URL="https://github.com/immich-app/immich/releases/latest/download/hwaccel.ml.yml"

ask_yes_no() {
    local prompt="$1"
    local default="${2:-n}"
    local reply
    read -rp "$prompt " reply
    reply="${reply:-$default}"
    case "${reply,,}" in
        y|yes) return 0 ;;
        *) return 1 ;;
    esac
}

get_url() {
    local prompt="$1"
    local url
    read -rp "$prompt " url
    echo "$url"
}

download() {
    local url="$1"
    local dest="$2"

    if [[ -z "$url" ]]; then
        echo "No URL provided for $dest, skipping."
        return
    fi

    if [[ -f "$dest" ]]; then
        echo "File '$dest' already exists."
        if ask_yes_no "Overwrite it? [y/N]"; then
            :
        else
            timestamp="$(date +%Y%m%d%H%M%S)"
            mv -- "$dest" "${dest}.bak.${timestamp}"
            echo "Existing file moved to ${dest}.bak.${timestamp}"
        fi
    fi

    if command -v wget >/dev/null 2>&1; then
        wget -O "$dest" "$url"
    elif command -v curl >/dev/null 2>&1; then
        curl -fsSL -o "$dest" "$url"
    else
        echo "Error: neither wget nor curl is available." >&2
        return 1
    fi

    echo "Saved to $dest"
}

echo "Fetch helper — run in the directory where you want the files saved."

if ask_yes_no "Download docker compose file ($COMPOSE_FILE)? [y/N]"; then
    url="$COMPOSE_URL"
    download "$url" "$COMPOSE_FILE"
fi

if ask_yes_no "Download hwaccel transcoding file ($HWACCEL_TRANSCODE)? [y/N]"; then
    url="$HWACCEL_TRANSCODE_URL"
    download "$url" "$HWACCEL_TRANSCODE"
fi

if ask_yes_no "Download hwaccel ml file ($HWACCEL_ML)? [y/N]"; then
    url="$HWACCEL_ML_URL"
    download "$url" "$HWACCEL_ML"
fi

echo "Done."
