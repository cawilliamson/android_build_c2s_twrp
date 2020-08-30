#!/usr/bin/env bash

# set git preferences
git config --global color.ui false

# change to twrp build dir
mkdir -p /usr/src/twrp
cd /usr/src/twrp

# init repo
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-10.0-WIP

# apply fix-manifests patch
patch -p1 --forward < /var/tmp/buildtwrp/patches/fix-manifests.patch || true

# create extra file
mkdir -p .repo/local_manifests/
cp -v /var/tmp/buildtwrp/manifests/extra.xml .repo/local_manifests/extra.xml

# sync repo
repo sync -c -j"$(nproc --all)" --force-sync --no-clone-bundle --no-tags

# apply android-10 patch
patch -p1 --forward < /var/tmp/buildtwrp/patches/android10-support.patch || true

# remove any potential leftover junk
rm -rf out/

# run actual build
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch omni_c2s-eng
mka -j$(nproc --all) recoveryimage

# copy image to output dir
cp -v out/target/product/c2s/recovery.img /var/tmp/buildtwrp/out/
chmod 666 /var/tmp/buildtwrp/out/recovery.img
