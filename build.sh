#!/bin/bash

BUILDROOT=/home/keith/build
PACKAGE=km1

cd $BUILDROOT
if [ -d "$BUILDROOT/$PACKAGE" ]; 
then 
	#rm -Rf $BUILDROOT/$PACKAGE; 
	cd $BUILDROOT/$PACKAGE
	git pull
	cd ..
else
	git clone "git@github.com:smudge1977/$PACKAGE.git"

fi


dpkg-deb --build $PACKAGE 

if [ -f "$BUILDROOT/$PACKAGE/DEBIAN/control" ]; then

	VERSION=$(cat $BUILDROOT/$PACKAGE/DEBIAN/control | grep Version | awk -F ' ' '{print $2}')
else
	VERSION=0
fi


echo Version is $VERSION
mv ${PACKAGE}.deb ${PACKAGE}_${VERSION}.deb
scp ${PACKAGE}_${VERSION}.deb keith@home001.local:/home/keith/ubuntu

