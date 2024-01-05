# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-info linux-mod-r1

DESCRIPTION="r8814 driver for Realtek 8814au wireless NICs"
HOMEPAGE="https://gitlab.com/kalilinux/packages/realtek-rtl8814au-dkms"
EGIT_REPO_URI="https://gitlab.com/kalilinux/packages/realtek-rtl8814au-dkms.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"

CONFIG_CHECK="USB CFG80211 REALTEK_PHY"

pkg_setup() {
	linux-mod-r1_pkg_setup
}

src_compile() {
	local modlist=( 8814au=/kernel/drivers/net/wireless/realtek/8814au )
	local modargs=( -C "${KV_DIR}" M="${S}" CONFIG_RTL8814AU=m )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	insinto /etc/modprobe.d/
	doins "${FILESDIR}/8814au.conf"
	einstalldocs
}
