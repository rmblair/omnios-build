#!/usr/bin/bash
#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License, Version 1.0 only
# (the "License").  You may not use this file except in compliance
# with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
#
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
# Portions Copyright 2013 Ryan Blair
#
# heavily based on https://github.com/stefri/omnios-build build/samba
#
# adds support for security=ADS (requires OpenLDAP and a krb5 patch)

# Load support functions
. ../../lib/functions.sh

PROG=samba
VER="3.6.18"
VERHUMAN=$VER
PKG=$PKGPUBLISHER/service/network/samba36
SUMMARY="${PROG}36 - CIFS server and domain controller"
DESC="$SUMMARY ($VER)"

#http://samba.org/samba/ftp/stable/samba-3.6.15.tar.gz

DEPENDS_IPS="service/network/dns/mdns \
 system/library \
 system/library/gcc-4-runtime \
 system/library/math \
 system/library/security/gss \
 $PKGPUBLISHER/library/openldap"

BUILD_DEPENDS_IPS="service/network/dns/mdns \
 developer/build/autoconf \
 system/library \
 system/library/gcc-4-runtime \
 system/library/math \
 system/library/security/gss \
 $PKGPUBLISHER/library/openldap"

BUILDDIR=$PROG-$VER/source3
BUILDARCH=64
CPPFLAGS="$(krb5-config --cflags) -I/opt/$PKGPUBLISHER/include"
LDFLAGS="-Wl,-rpath=/opt/$PKGPUBLISHER/lib -L/opt/$PKGPUBLISHER/lib $(krb5-config --libs) -lgss"
CONFIGURE_OPTS="
    --bindir=$PREFIX/bin
    --sbindir=$PREFIX/sbin
    --mandir=$PREFIX/man
    --infodir=$PREFIX/info
    --sysconfdir=/etc/samba
    --with-configdir=/etc/samba
    --with-privatedir=/etc/samba/private
    --localstatedir=/var/samba
    --sharedstatedir=/var/samba
    --with-nmbdsocketdir=/var/run/nmbd
    --enable-static=no
    --disable-static
    --disable-swat
    --with-acl-support
    --with-ads
"
#    --with-sendfile-support
#    --with-dnsupdate
#    --enable-fhs

service_configs() {
    logmsg "Installing SMF"
    logcmd mkdir -p $DESTDIR/lib/svc/manifest/network/samba36
    logcmd cp $SRCDIR/files/manifest-samba-nmbd.xml \
        $DESTDIR/lib/svc/manifest/network/samba36/nmbd.xml
    logcmd cp $SRCDIR/files/manifest-samba-smbd.xml \
        $DESTDIR/lib/svc/manifest/network/samba36/smbd.xml
    logcmd cp $SRCDIR/files/manifest-samba-winbindd.xml \
        $DESTDIR/lib/svc/manifest/network/samba36/winbindd.xml
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
service_configs
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:
