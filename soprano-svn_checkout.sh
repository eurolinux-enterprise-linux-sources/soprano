#/bin/sh

DATE=$(date +%Y%m%d)
EXPORT_DIR=soprano

set -x
rm -rf $EXPORT_DIR
# app
svn export svn://anonsvn.kde.org/home/kde/trunk/kdesupport/soprano $EXPORT_DIR/

tar cjf $EXPORT_DIR-${DATE}svn.tar.bz2 $EXPORT_DIR

# cleanup
rm -rf $EXPORT_DIR

