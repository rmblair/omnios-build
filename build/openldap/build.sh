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
# build client-only OpenLDAP (to provide support for Samba and other
# packages that need OpenLDAP-flavored client libs as opposed to
# Sun-flavored)

# Load support functions
. ../../lib/functions.sh

PROG=openldap  # App name
VER=2.4.34     # App version
VERHUMAN=$VER  # Human-readable version
#PVER=         # Branch (set in config.sh, override here if needed)
PKG=$PKGPUBLISHER/library/openldap # Package name (e.g. library/foo)
SUMMARY="open source implementation of the Lightweight Directory Access Protocol." # One-liner, must be filled in
DESC="open source implementation of the Lightweight Directory Access Protocol."    # Longer description, must be filled in

DEPENDS_IPS="system/library \
    system/library/gcc-4-runtime \
    system/library/math \
    library/security/openssl \
    system/library/security/libsasl"
### only if you're building slapd
#    omniti/database/bdb

BUILDDIR=$PROG-$VER/
BUILDARCH=32

### only if you're building slapd
#CPPFLAGS="-I/opt/omni/include/"
#LDFLAGS="-Wl,-rpath=/opt/omni/lib -L/opt/omni/lib"

PREFIX="/opt/${PKGPUBLISHER}"
CONFIGURE_OPTS="
    --prefix=$PREFIX
    --bindir=$PREFIX/bin
    --sbindir=$PREFIX/sbin
    --mandir=$PREFIX/man
    --infodir=$PREFIX/info
    --includedir=$PREFIX/include
    --sysconfdir=$PREFIX/etc
    --libexecdir=$PREFIX/libexec
    --libdir=$PREFIX/lib
    --localstatedir=$PREFIX/var
    --enable-dynamic
    --enable-static=no
    --disable-static
    --with-tls
    --enable-ipv6
    --enable-local
    --enable-syslog
    --disable-slapd
"
### only if you're building slapd
#    --enable-bdb

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
#fix_permissions
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:
