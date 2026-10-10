#!/bin/bash
set -e

DEBIAN_VERSION="${DEBIAN_VERSION:-trixie}"
UBUNTU_VERSION="${UBUNTU_VERSION:-resolute}"
BOOT_IMG="${BOOT_IMG:-xiaomi-k20pro-boot.img}"
SYSTEM_TYPE="${SYSTEM_TYPE:-ubuntu-server}"
BOOTSTRAP_TOOL="${BOOTSTRAP_TOOL:-mmdebstrap}"
ARCH="${ARCH:-arm64}"

echo "[$(date +'%Y-%m-%d %H:%M:%S')] 🚀 安装基础系统"

if [[ "$SYSTEM_TYPE" == *"debian-"* ]]; then
    echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 使用 $BOOTSTRAP_TOOL 构建 Debian $DEBIAN_VERSION 🐧"
    OS_VERSION="$DEBIAN_VERSION"
    MIRROR="http://deb.debian.org/debian/"
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 使用 $BOOTSTRAP_TOOL 构建 Ubuntu $UBUNTU_VERSION 🦁"
    OS_VERSION="$UBUNTU_VERSION"
    MIRROR="http://ports.ubuntu.com/ubuntu-ports/"
fi

echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 开始 bootstrap (这可能需要几分钟...)"
if [ "$BOOTSTRAP_TOOL" = "mmdebstrap" ]; then
    # 必须显式指定目标架构：默认会跟随宿主架构，而 Raphael 是 arm64，
    # Ubuntu ports 源只提供 arm64 索引（在 x86_64 上不指定会抓到不存在的 amd64 索引）
    mmdebstrap --architectures="$ARCH" $OS_VERSION rootdir
elif [ "$BOOTSTRAP_TOOL" = "debootstrap" ]; then
    debootstrap --arch="$ARCH" $OS_VERSION rootdir $MIRROR
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] ❌ 错误: 不支持的构建工具: $BOOTSTRAP_TOOL"
    exit 1
fi

if [ -f "${BOOT_IMG}" ]; then
    echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 挂载 boot 分区 (${BOOT_IMG}) 📁"
    if mount -o loop ${BOOT_IMG} rootdir/boot 2>&1; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ Boot 分区挂载成功"
    else
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] ❌ 错误: Boot 分区挂载失败"
        exit 1
    fi
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] ❌ 错误: ${BOOT_IMG} 不存在"
    exit 1
fi

echo "[$(date +'%Y-%m-%d %H:%M:%S')] ✅ 基础系统安装完成"