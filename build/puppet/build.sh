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

PROG=puppet     # App name
VER=3.1.1       # App version
VERHUMAN=$VER   # Human-readable version
#PVER=          # Branch (set in config.sh, override here if needed)
PKG=${PKGPUBLISHER}/system/management/puppet  # Package name (e.g. library/foo)
SUMMARY="A network tool for managing many disparate systems"
DESC="Puppet lets you centrally manage every important aspect of your system using a cross-platform specification language that manages all the separate elements normally aggregated in different files, like users, cron jobs, and hosts along with obviously discrete elements like packages, services, and files."

DEPENDS_IPS="omniti/runtime/ruby-19 \
$PKGPUBLISHER/developer/docutils \
$PKGPUBLISHER/system/management/facter \
$PKGPUBLISHER/library/ruby/augeas"

BUILD_DEPENDS_IPS="omniti/runtime/ruby-19 \
$PKGPUBLISHER/developer/docutils"

just_install_it() {
    logmsg "Just installing it!"
    logcmd mkdir -p $DESTDIR/opt/puppet/bin
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
