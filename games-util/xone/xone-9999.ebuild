# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-info linux-mod-r1

DESCRIPTION="Linux kernel driver for Xbox One and Xbox Series X|S accessories."
HOMEPAGE="https://github.com/medusalix/xone"
EGIT_REPO_URI="https://github.com/medusalix/xone"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
NIH_SOURCE="${KV_OUT_DIR}"

pkg_setup() {
	linux-mod-r1_pkg_setup
}

src_compile() {
	local modlist=(
			xone-wired=/kernel/drivers/input/joystick
			xone-dongle=/kernel/drivers/input/joystick
			xone-gip=/kernel/drivers/input/joystick
			xone-gip-gamepad=/kernel/drivers/input/joystick
			xone-gip-headset=/kernel/drivers/input/joystick
			xone-gip-chatpad=/kernel/drivers/input/joystick
			xone-gip-guitar=/kernel/drivers/input/joystick
	)
	echo "NIH_SOURCE ${NIH_SOURCE}"
	local modargs=( -C "${KV_DIR}" M="${S}"  )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	insinto /etc/modprobe.d
	doins  install/modprobe.conf
	insinto /lib/firmware/
	doins ${FILESDIR}/FW_ACC_00U.bin
}
