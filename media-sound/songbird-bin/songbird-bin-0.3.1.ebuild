
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

MY_PN="Songbird"
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="A multimedia player, inspired by iTunes"
HOMEPAGE="http://www.songbirdnest.com/"
SRC_URI="x86? ( http://download.songbirdnest.com/installer/linux/i686/${MY_PN}_0.3.1_linux-i686.tar.gz )
   amd64? ( http://download.songbirdnest.com/installer/linux/x86_64/${MY_PN}_0.3.1_linux-x86_64.tar.gz ) "
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa oss esd ogg flac faac musepack ugly theora speex ffmpeg gnome"
RESTRICT="strip"
RDEPEND="
   alsa? ( media-plugins/gst-plugins-alsa )
   oss?  ( media-plugins/gst-plugins-oss )
   esd?  ( media-plugins/gst-plugins-esd )
   ogg? ( media-plugins/gst-plugins-ogg
      media-plugins/gst-plugins-vorbis )
   gnome? ( media-plugins/gst-plugins-gconf
      media-plugins/gst-plugins-gnomevfs )
   flac? ( media-plugins/gst-plugins-flac )
   faac? ( media-plugins/gst-plugins-faac )
   ugly?  ( media-libs/gst-plugins-ugly )
   musepack? ( media-plugins/gst-plugins-musepack )
   theora? ( media-plugins/gst-plugins-theora )
   speex? ( media-plugins/gst-plugins-speex )
   ffmpeg? ( media-plugins/gst-plugins-ffmpeg )"
DEPEND="${RDEPEND}
   x11-libs/libXdmcp
   x11-libs/libXau
   x11-libs/libXfixes
   x11-libs/libXcursor
   x11-libs/libXrandr
   x11-libs/libXi
   x11-libs/libXrender
   x11-libs/libXext
   x11-libs/libX11
   dev-libs/liboil
   media-libs/gstreamer
   media-libs/gst-plugins-base
   media-plugins/gst-plugins-x
   media-plugins/gst-plugins-xvideo
   media-plugins/gst-plugins-lame
   media-plugins/gst-plugins-mpeg2dec
   media-plugins/gst-plugins-mad
   >=sys-libs/glibc-2.3.2
    >=x11-libs/gtk+-2.0.0
    >=virtual/xft-7.0
    >=virtual/libstdc++-3.3
   x11-libs/pango"

src_install() {
   insinto /opt/songbird
   doins -r *
   fperms 755 /opt/songbird/songbird
   fperms 755 /opt/songbird/xulrunner/xulrunner
   fperms 755 /opt/songbird/xulrunner/xulrunner-bin
   dosym /opt/songbird/songbird /opt/bin/songbird-bin

   newicon ${S}/chrome/icons/default/default.xpm ${PN}.xpm
   make_desktop_entry ${PN} ${PN} ${PN}.xpm "AudioVideo;Player"
}

pkg_postinst() {
   echo
   ewarn "Songbird is still under development!"
   einfo ""
   einfo "If You need other music/video plugins, look at"
   einfo "Your portage tree into media-plugins/gst-plugins-*,"
   einfo "but remember, that not all plugins are supported yet."
   einfo ""
   einfo "If You don't want too much deps on these package,"
   einfo "disable gnome support"
   echo
} 

