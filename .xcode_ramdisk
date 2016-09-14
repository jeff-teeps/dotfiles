#!/bin/sh
# Create a RAM disk with same perms as mountpoint
# Script based on http://itux.idev.pro/2012/04/iservice-speed-up-your-xcode-%D0%BD%D0%B5%D0%BA%D0%BE%D1%82%D0%BE%D1%80%D1%8B%D0%B5-%D1%81%D0%BF%D0%BE%D1%81%D0%BE%D0%B1%D1%8B/ with some additions
# Usage: sudo ./xcode_ramdisk.sh start

# PREREQUISITE:
# mkdir /Users/$USERNAME/Library/Developer/Xcode/DerivedData.shadow
## Unless you clear DerivedData folder, you can't mount ramdisk on it
# rm -r /Users/$USERNAME/Library/Developer/Xcode/DerivedData/*

# MAINTENANCE
# Keep the size of DerivedData folder below the Ramdisk size

USERNAME=$(logname)

DEV_CACHES_DIR="/Users/$USERNAME/Library/Developer/Xcode/DerivedData"
DEV_CACHES_SHADOW_DIR="/Users/$USERNAME/Library/Developer/Xcode/DerivedData.shadow"

RAMDisk() {
	mntpt="$1"
	rdsize=$(($2*1024*1024/512))

	# Create the RAM disk.
	dev=`hdik -drivekey system-image=yes -nomount ram://$rdsize`
	# Successfull creation...
	if [ $? -eq 0 ] ; then
	# Create HFS on the RAM volume.
	newfs_hfs $dev
	# Store permissions from old mount point.
	eval `/usr/bin/stat -s "$mntpt"`
	# Mount the RAM disk to the target mount point.
	mount -t hfs -o union -o nobrowse -o nodev -o noatime $dev "$mntpt"
	# Restore permissions like they were on old volume.
	chown $st_uid:$st_gid "$mntpt"
	chmod $st_mode "$mntpt"
	
	echo "Creating RamFS for $mntpt $rdsize $dev"
	fi
}

UmountDisk() {
	mntpt="$1"
	dev=`mount | grep "$mntpt" | grep hfs | cut -f 1 -d ' '`
	umount -f "$mntpt"
	hdiutil detach "$dev"
	echo "Umount RamFS for $mntpt $dev"
	echo ""
}

# Test for arguments.
if [ -z $1 ]; then
echo "Usage: $0 [start|stop] "
exit 1
fi

# Source the common setup functions for startup scripts
test -r /etc/rc.common || exit 1 
. /etc/rc.common

StartService () {
	ConsoleMessage "Starting RamFS disks..."
	RAMDisk "$DEV_CACHES_DIR" 1024	
	cp -rp "$DEV_CACHES_SHADOW_DIR/"* "$DEV_CACHES_DIR/"	
}

StopService () {
	if [ -z "$(pgrep Xcode)" ]; then
		ConsoleMessage "Stopping RamFS disks..."
		/usr/bin/rsync -aqr --delete "$DEV_CACHES_DIR/" "$DEV_CACHES_SHADOW_DIR/"
		UmountDisk "$DEV_CACHES_DIR"
	else
		echo "Xcode is running, please close first."
	fi	
}

RunService "$1"
