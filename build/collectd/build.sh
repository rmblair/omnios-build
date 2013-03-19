#!/usr/bin/bash
set +x
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
#
# Load support functions
. ../../lib/functions.sh

PROG=collectd   # App name
VER=5.1.2       # App version
VERHUMAN=$VER   # Human-readable version
#PVER=          # Branch (set in config.sh, override here if needed)
PKG=$PKGPUBLISHER/monitoring/collectd            # Package name (e.g. library/foo)
SUMMARY="$PROG - System information collection daemon"   # One-liner, must be filled in
DESC="$SUMMARY ($VER)"         # Longer description, must be filled in
 
DEPENDS_IPS="developer/build/autoconf \
 system/library \
 system/library/gcc-4-runtime"
BUILDDIR=$PROG-$VER
BUILDARCH=64

CONFIGURE_OPTS="
    --without-libgcrypt
    --without-libhal
    --disable-uuid
    --disable-powerdns
    --disable-csv
    --disable-multimeter
    --disable-olsrd
    --disable-openvpn
    --disable-teamspeak2
    --disable-ted 
"
service_configs() {
    logmsg "Installing SMF"
    logcmd mkdir -p $DESTDIR/lib/svc/manifest/network
    logcmd cp $SRCDIR/files/manifest-collectd.xml \
        $DESTDIR/lib/svc/manifest/network/manifest-collectd.xml
}
default_config() {
    logmsg "Installing default config"
    logcmd cp $SRCDIR/files/collectd.conf \
        $DESTDIR/etc/collectd.conf
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
service_configs
default_config
#fix_permissions
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:
