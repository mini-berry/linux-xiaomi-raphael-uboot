# 系统类型到基础设置的映射
system_config() {
  case "$1" in
    "debian-server")
      echo "DEBIAN_VERSION=${DEBIAN_VERSION:-trixie}"
      echo "IMAGE_SIZE=3G"
      echo "IS_DESKTOP=false"
      echo "DESKTOP_ENV="
      ;;
    "debian-gnome")
      echo "DEBIAN_VERSION=${DEBIAN_VERSION:-trixie}"
      echo "IMAGE_SIZE=6G"
      echo "IS_DESKTOP=true"
      echo "DESKTOP_ENV=gnome"
      ;;
    "debian-kde")
      echo "DEBIAN_VERSION=${DEBIAN_VERSION:-trixie}"
      echo "IMAGE_SIZE=6G"
      echo "IS_DESKTOP=true"
      echo "DESKTOP_ENV=kde"
      ;;
    "debian-phosh")
      echo "DEBIAN_VERSION=${DEBIAN_VERSION:-trixie}"
      echo "IMAGE_SIZE=6G"
      echo "IS_DESKTOP=true"
      echo "DESKTOP_ENV=$2"
      ;;
    "ubuntu-server")
      echo "UBUNTU_VERSION=${UBUNTU_VERSION:-resolute}"
      echo "IMAGE_SIZE=3G"
      echo "IS_DESKTOP=false"
      echo "DESKTOP_ENV="
      ;;
    "ubuntu-gnome")
      echo "UBUNTU_VERSION=${UBUNTU_VERSION:-resolute}"
      echo "IMAGE_SIZE=6G"
      echo "IS_DESKTOP=true"
      echo "DESKTOP_ENV=gnome"
      ;;
    "ubuntu-kde")
      echo "UBUNTU_VERSION=${UBUNTU_VERSION:-resolute}"
      echo "IMAGE_SIZE=6G"
      echo "IS_DESKTOP=true"
      echo "DESKTOP_ENV=kde"
      ;;
    "ubuntu-phosh")
      echo "UBUNTU_VERSION=${UBUNTU_VERSION:-resolute}"
      echo "IMAGE_SIZE=6G"
      echo "IS_DESKTOP=true"
      echo "DESKTOP_ENV=$2"
      ;;
  esac
}