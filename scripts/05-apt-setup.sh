#!/bin/bash
set -e

echo "[$(date +'%Y-%m-%d %H:%M:%S')] 📡 更新 apt 源并更新缓存"

export DEBIAN_FRONTEND=noninteractive

ARCH="${ARCH:-arm64}"

mv rootdir/etc/apt/sources.list rootdir/etc/apt/sources.list.bak

if [[ "$SYSTEM_TYPE" == *"ubuntu-"* ]]; then
    echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 配置 Ubuntu $UBUNTU_VERSION 源 (架构: $ARCH)"
    cat > rootdir/etc/apt/sources.list.d/ubuntu.sources << EOF
Types: deb
URIs: http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports
Suites: $UBUNTU_VERSION $UBUNTU_VERSION-updates $UBUNTU_VERSION-backports
Components: main restricted universe multiverse
Architectures: $ARCH
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: http://ports.ubuntu.com/ubuntu-ports/
Suites: $UBUNTU_VERSION-security
Components: main restricted universe multiverse
Architectures: $ARCH
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 配置 Debian $DEBIAN_VERSION 源 (架构: $ARCH)"
    cat > rootdir/etc/apt/sources.list.d/debian.sources << EOF
Types: deb
URIs: http://mirrors.tuna.tsinghua.edu.cn/debian
Suites: $DEBIAN_VERSION $DEBIAN_VERSION-updates $DEBIAN_VERSION-backports
Components: main contrib non-free non-free-firmware
Architectures: $ARCH
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: http://security.debian.org/debian-security
Suites: $DEBIAN_VERSION-security
Components: main contrib non-free non-free-firmware
Architectures: $ARCH
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
fi

echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 执行 apt-get update..."
chroot rootdir apt-get -q update

echo "[$(date +'%Y-%m-%d %H:%M:%S')] ✅ apt 配置完成"