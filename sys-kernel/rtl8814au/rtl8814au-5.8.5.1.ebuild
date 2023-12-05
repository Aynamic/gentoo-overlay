# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info linux-mod git-r3

DESCRIPTION="r8814 driver for Realtek 8814au wireless NICs"
HOMEPAGE="https://gitlab.com/kalilinux/packages/realtek-rtl8814au-dkms"
EGIT_REPO_URI="https://gitlab.com/kalilinux/packages/realtek-rtl8814au-dkms.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"

MODULE_NAMES="8814au(kernel/net/wireless)"
BUILD_TARGETS="modules"


CONFIG_CHECK="USB CFG80211 REALTEK_PHY"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="-C ${KV_DIR} M=${S} CONFIG_RTL8814AU=m"
}

src_install() {
	linux-mod_src_install
	insinto /etc/modprobe.d/
	doins "${FILESDIR}/8814au.conf"
	einstalldocs
}
