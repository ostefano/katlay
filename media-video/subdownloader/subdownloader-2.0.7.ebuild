# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Tool for automatic download/upload subtitles for videofiles."
HOMEPAGE="http://www.subdownloader.net/"
SRC_URI="http://code.launchpad.net/${PN}/trunk/${PV}/+download/${P/-/_}.tar.gz"
PREFIX="/usr/share"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/PyQt4 dev-python/sip"

inherit eutils

src_unpack() {
	unpack ${A}
	cd "${S}" || die
}

src_install() {
	insinto ${PREFIX}/subdownloader
	doins -r cli FileManagement gui __init__.py languages modules run.py
	chmod +x ${D}${PREFIX}/subdownloader/run.py
	echo '#!/bin/sh' > ${D}${PREFIX}/subdownloader/subdownloader
	echo 'cd "'${PREFIX}'/subdownloader/"' >> ${D}${PREFIX}/subdownloader/subdownloader
	echo 'if [ -n "'${PREFIX}'/subdownloader/" ] ; then' >> ${D}${PREFIX}/subdownloader/subdownloader
	echo 'if [ "${LD_LIBRARY_PATH+set}" = "set" ] ; then' >> ${D}${PREFIX}/subdownloader/subdownloader
	echo 'export' >> ${D}${PREFIX}/subdownloader/subdownloader
	echo 'LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:'${PREFIX}'/subdownloader/"' >> ${D}${PREFIX}/subdownloader/subdownloader
	echo 'else' >> ${D}${PREFIX}/subdownloader/subdownloader
	echo 'export' >> ${D}${PREFIX}/subdownloader/subdownloader
	echo 'LD_LIBRARY_PATH="'${PREFIX}'/subdownloader/"' >> ${D}${PREFIX}/subdownloader/subdownloader
	echo 'fi' >> ${D}${PREFIX}/subdownloader/subdownloader
	echo 'fi' >> ${D}${PREFIX}/subdownloader/subdownloader
	echo 'exec ./run.py "$@"' >> ${D}${PREFIX}/subdownloader/subdownloader
	chmod +x ${D}${PREFIX}/subdownloader/subdownloader
	dobin ${D}${PREFIX}/subdownloader/subdownloader
	doman subdownloader.1
	dodoc README ChangeLog
	doicon gui/images/subdownloader.png
	domenu subdownloader.desktop
}
