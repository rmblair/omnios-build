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
# Copyright 2011-2013 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
#
# Load support functions
. ../../lib/functions.sh

PROG=vippy
VER=0.0.4
PKG=omniti/runtime/nodejs/$PROG
SUMMARY="VIP management (juggler of IPs)"
DESC="$SUMMARY"

BUILD_DEPENDS_IPS="omniti/runtime/nodejs"
DEPENDS_IPS="omniti/runtime/nodejs"

BUILDARCH=64

PATH=/usr/gnu/bin:$PATH
export PATH

copy_manifest() {
    # SMF manifest
    logmsg "--- Copying SMF manifest"
    logcmd mkdir -p ${DESTDIR}/lib/svc/manifest/network
    logcmd cp $SRCDIR/files/vippy.xml ${DESTDIR}/lib/svc/manifest/network
}

init
prep_build
build_npm
copy_manifest
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et: