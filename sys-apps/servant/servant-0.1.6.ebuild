# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Graphical rc-update replacement (Qt4)"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://www.informatik.uni-bremen.de/~momesana/sys-apps/servant/"
SRC_URI="http://www.informatik.uni-bremen.de/~momesana/sys-apps/servant/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=x11-libs/qt-4.2.0"
S=${WORKDIR}/${PN}

src_compile() {
	qmake || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin ${S}/servant || die "dobin ${S}/servant failed"
	
	dodoc ${S}/AUTHORS \
		${S}/COPYING \
		${S}/ChangeLog \
		${S}/README \
		${S}/TODO || die "installing documentation failed"
	insinto /usr/share/applnk/System/
	doins ${S}/servant.desktop
}

pkg_postinst() {
	einfo "Send your Bugreports to momesana@yahoo.de"
}
