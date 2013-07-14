# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator
#MY_PV=$(get_version_component_range 1-3)
#MY_PV2=$(replace_all_version_separators '' $(get_version_component_range 4-5))
MY_PV=$PV

DESCRIPTION="Oracle SQL Developer"
HOMEPAGE="http://www.oracle.com/technology/products/database/sql_developer/index.html"
SRC_URI="${PN}-${MY_PV}-no-jre.zip"
LICENSE="OTN"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""
SLOT="0"

DEPEND="app-arch/unzip"
RDEPEND=">=dev-java/sun-jdk-1.5"

pkg_nofetch() {
	einfo "Please download ${PN}-${MY_PV}-no-jre.zip from:"
	einfo "http://www.oracle.com/technology/software/products/sql/index.html"
	einfo "and move it to ${DISTDIR}"
}

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${PN}-${MY_PV}-no-jre.zip
	rm ${PN}/${PN}.exe
	cd ${S}
}

src_install() {
	dodir /opt/sqldeveloper
	cp -r {ide,j2ee,jdbc,jdev,jlib,lib,rdbms,sqldeveloper} ${D}/opt/sqldeveloper/

	exeinto /opt/sqldeveloper
	doexe sqldeveloper.sh

	dodir /usr/bin
	# Build wrapper.  Launch the sqldeveloper.sh from the correct directory
	cat > ${D}/usr/bin/sqldeveloper <<-EOF
	#!/bin/bash
	# Copyright 1999-2007 Gentoo Foundation
	# Distributed under the terms of the GNU General Public License v2
	#
	cd /opt/sqldeveloper
	sh sqldeveloper.sh
	EOF

	chmod 755 ${D}/usr/bin/sqldeveloper

	exeinto /usr/bin
	doexe /usr/bin/sqldeveloper

	mv icon.png sqldeveloper.png
	insinto /usr/share/pixmaps
	doins sqldeveloper.png
	make_desktop_entry sqldeveloper "Oracle SQL Developer" sqldeveloper.png	Development

	dodoc readme.txt
}
