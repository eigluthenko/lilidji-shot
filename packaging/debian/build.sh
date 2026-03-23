#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-1.0.2-1}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
PACKAGING_DIR="${ROOT_DIR}/packaging/debian"
WORK_DIR="${PACKAGING_DIR}/build"
PKG_DIR="${WORK_DIR}/lilidji-shot_${VERSION}"
OUTPUT_DEB="${PACKAGING_DIR}/lilidji-shot_${VERSION}_all.deb"

rm -rf "${PKG_DIR}" "${OUTPUT_DEB}"

install -d "${PKG_DIR}/DEBIAN"
install -d "${PKG_DIR}/usr/bin"
install -d "${PKG_DIR}/usr/share/applications"
install -d "${PKG_DIR}/etc/xdg/autostart"
install -d "${PKG_DIR}/usr/share/doc/lilidji-shot"

install -m 0755 "${ROOT_DIR}/scripts/lilidji-shot" "${PKG_DIR}/usr/bin/lilidji-shot"
install -m 0755 "${ROOT_DIR}/scripts/lilidji-shot-ui" "${PKG_DIR}/usr/bin/lilidji-shot-ui"
install -m 0755 "${ROOT_DIR}/scripts/codex-image-paste" "${PKG_DIR}/usr/bin/codex-image-paste"
install -m 0755 "${ROOT_DIR}/scripts/lilidji-shot-session-setup" "${PKG_DIR}/usr/bin/lilidji-shot-session-setup"
install -m 0644 "${ROOT_DIR}/desktop/lilidji-screenshot.desktop" "${PKG_DIR}/usr/share/applications/lilidji-screenshot.desktop"
install -m 0644 "${ROOT_DIR}/desktop/lilidji-shot-session-setup.desktop" "${PKG_DIR}/etc/xdg/autostart/lilidji-shot-session-setup.desktop"
install -m 0644 "${PACKAGING_DIR}/README.Debian" "${PKG_DIR}/usr/share/doc/lilidji-shot/README.Debian"

cat > "${PKG_DIR}/DEBIAN/control" <<EOF
Package: lilidji-shot
Version: ${VERSION}
Section: utils
Priority: optional
Architecture: all
Maintainer: lilidji <lilidji@localhost>
Depends: python3, python3-gi, python3-cairo, gir1.2-gtk-3.0, gir1.2-pango-1.0, xclip, xdotool, x11-utils, xdg-utils, xdg-user-dirs, libnotify-bin, flameshot, gsettings-desktop-schemas
Description: Скриншотер с аннотациями, буфером обмена и интеграцией с Codex CLI
 Минималистичный серый интерфейс на русском для X11.
 Сохраняет скриншоты в Pictures/Screenshots, копирует их в буфер обмена,
 поддерживает аннотации и настраивает горячие клавиши GNOME.
 Добавляет helper для вставки изображений в Codex CLI по Ctrl+Shift+V.
EOF

install -m 0755 "${PACKAGING_DIR}/postinst" "${PKG_DIR}/DEBIAN/postinst"

dpkg-deb --root-owner-group --build "${PKG_DIR}" "${OUTPUT_DEB}"
echo "${OUTPUT_DEB}"
