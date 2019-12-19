#!/usr/bin/sh

set -e
set -u

readonly APP="io.itch.marvellous-inc"
readonly MANIFEST="${APP}.yml"
readonly REPO="love2d"
readonly APP_VERSION="$(grep base-version "${MANIFEST}" | cut --delimiter \' --field 2)"
readonly RUNTIME_VERSION="$(grep runtime-version "${MANIFEST}" | cut --delimiter \' --field 2)"
readonly BUNDLE="${APP}-${APP_VERSION}.flatpak"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak-builder --force-clean \
                --repo="${REPO}" \
                build-dir \
                "${MANIFEST}"

flatpak build-bundle \
        --arch=x86_64 \
        "${REPO}" \
        "${BUNDLE}" \
        "${APP}" 
	#\ "${APP_VERSION}"
