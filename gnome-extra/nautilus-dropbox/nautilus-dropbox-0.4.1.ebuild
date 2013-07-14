# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils gnome2

DESCRIPTION="Store, Sync and Share Files Online"
HOMEPAGE="http://www.getdropbox.com/"
SRC_URI="http://dl.getdropbox.com/u/5143/nautilus-dropbox-packages/${PV}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=gnome-base/nautilus-2.16
	>=x11-libs/gtk+-2.12
	>=net-misc/wget-1.10
	>=dev-libs/glib-2.14
	>=x11-libs/libnotify-0.4.4"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch "${FILESDIR}"/disablecheck-update-0.4.1.patch
}


pkg_setup() {
	G2CONF="${G2CONF} $(use_enable debug)"
}
