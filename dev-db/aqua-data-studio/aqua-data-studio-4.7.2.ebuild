# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils java

DESCRIPTION="Java-Based/Graphical SQL Client"
HOMEPAGE="http://www.aquafold.com"
SRC_URI="http://download.aquafold.com/download/v${PV}/java/ads-java-novm-${PV}.tar.gz"
LICENSE="aquafold"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sparc x86 x86-fbsd"
IUSE="X java"
DEPEND=">=virtual/jre-1.5"
NAME="datastudio"

S=${WORKDIR}/${NAME}

src_install() {
	mkdir -p ${D}/opt/${NAME}
	cp -r ${S}/* ${D}/opt/${NAME}

	mkdir -p ${D}/opt/bin
	echo "#!/bin/bash" >  ${D}/opt/bin/${NAME}
	echo "cd /opt/datastudio" >> ${D}/opt/bin/${NAME}
	echo "alias java=\"java -Dsun.swing.enableImprovedDragGesture -Xmx256M\"" >> ${D}/opt/bin/${NAME}
	echo "./datastudio.sh" >> ${D}/opt/bin/${NAME}
	chmod +x ${D}/opt/bin/${NAME}

}

pkg_postinst() {
	# set default vm if none exists
	java_pkg_postinst
	
	echo ""
	ewarn "Please review the license agreement in /opt/${NAME}/License.txt"
	ewarn "If you do not agree to the terms of this license, uninstall this"
	ewarn "package!"
	echo ""
	ewarn "Please refer to the Java-1.5 FAQ if you have problems mixing"
	ewarn "Java versions 1.5 and lower. Generally, use 1.4 as system vm"
	ewarn "and 1.5 as your user vm"
	ewarn "http://www.gentoo.org/proj/en/java/tiger-faq.xml"
	echo ""
}

