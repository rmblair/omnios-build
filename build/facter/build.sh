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
# Portions Copyright 2013 Greg Mason
#
# Load support functions
. ../../lib/functions.sh

PROG=facter     # App name
VER=1.7.2      # App version
VERHUMAN=$VER   # Human-readable version
#PVER=          # Branch (set in config.sh, override here if needed)
PKG=${PKGPUBLISHER}/system/management/facter  # Package name (e.g. library/foo)
SUMMARY="Command and ruby library for gathering system information"
DESC="Facter is an independent, cross-platform Ruby library designed to gather information on all the nodes you will be managing with Puppet. It is available on all platforms that Puppet is available."

DEPENDS_IPS="omniti/runtime/ruby-19 \
$PKGPUBLISHER/developer/docutils"
BUILD_DEPENDS_IPS="omniti/runtime/ruby-19 \
$PKGPUBLISHER/developer/docutils"

just_install_it() {
    logmsg "Just installing it!"
    logcmd pushd $TMPDIR/$BUILDDIR > /dev/null
    logcmd /opt/omni/bin/ruby install.rb --destdir=${DESTDIR} --full --bindir=/usr/bin
    logcmd popd > /dev/null
}

init
download_source $PROG $PROG $VER
prep_build
make_isa_stub
just_install_it
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:
