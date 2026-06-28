#!/bin/bash
set -e

if [ ! -f "$1" ]; then
    echo "Recovery image not found."
    exit 1
fi

if ! command -v lz4 >/dev/null 2>&1; then
    echo "lz4 is not installed."
    exit 1
fi

if file "$1" | grep -q "LZ4 compressed data"; then
    cp "$1" r.img.lz4
    lz4 -d -f r.img.lz4 r.img
else
    cp "$1" r.img
fi

if [ ! -f phh.pem ]; then
    openssl genrsa -out phh.pem 4096
fi
