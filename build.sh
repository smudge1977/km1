#!/bin/bash

BUILDROOT=/home/keith/build
PACKAGE=km1

if [ -d "$BUILDROOT/$PACKAGE" ]; then rm -Rf $BUILDROOT/$PACKAGE; fi

git clone "git@github.com:smudge1977/$PACKAGE.git"

dpkg-deb --build $PACKAGE 

if [ -f "$BUILDROOT/$PACKAGE/DEBIAN/control" ]; then

	VERSION=$(cat $BUILDROOT/$PACKAGE/DEBIAN/control | grep Version | awk -F ' ' '{print $2}')

fi

mv $PACKAGE.deb $PACKAGE_$VERSION.deb
scp $PACKAGE_$VERSION.deb keith@home001.local:/home/keith/ubuntu

