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
# Load support functions
. ../../lib/functions.sh

PROG=ruby-augeas      # App name
VER=0.5.0            # App version
VERHUMAN=$VER   # Human-readable version
#PVER=          # Branch (set in config.sh, override here if needed)
PKG="$PKGPUBLISHER/library/ruby/augeas" # Package name (e.g. library/foo)
SUMMARY="Ruby bindings for Augeas configuration API"  # One-liner
DESC="$SUMMARY ($VER)"  # Longer description, must be filled in

BUILD_DEPENDS_IPS=" \
  $PKGPUBLISHER/system/management/augeas \
  omniti/runtime/ruby-19 \
  library/libxml2 \
"

DEPENDS_IPS="
  $PKGPUBLISHER/system/management/augeas \
  omniti/runtime/ruby-19 \
  library/libxml2 \
"

#modified from ../lib/gem-functions.sh
GEM_BIN=/opt/omni/bin/gem
RAKE_BIN=/opt/omni/bin/rake
RUBY_VER=1.9.1
# match where omni ruby-19 lives
PREFIX=/opt/omni
custom_build32() {
    logmsg "Building"

    if [[ -e $SRCDIR/files/gemrc ]]; then
        GEMRC=$SRCDIR/files/gemrc
    else
        GEMRC=$MYDIR/gemrc
    fi

    pushd $TMPDIR/$BUILDDIR > /dev/null
    GEM_HOME=${DESTDIR}${PREFIX}/lib/ruby/gems/${RUBY_VER}
    export GEM_HOME

    # build as a gem first ...
    logmsg "--- rake gem $PROG-$VER"
    logcmd $RAKE_BIN -v -t gem|| \
        logerr "Failed to rake gem $PROG-$VER"

    # then gem install it from local
    logmsg "--- gem install $PROG-$VER"
    logcmd $GEM_BIN --config-file $GEMRC install \
         --no-rdoc --no-ri --install-dir ${GEM_HOME} \
         --local pkg/$PROG-$VER.gem || \
        logerr "Failed to gem install $PROG-$VER"
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
custom_build32
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:
