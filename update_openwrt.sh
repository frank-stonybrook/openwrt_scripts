VERSION=$1

if [ "${VERSION}" = "23.05.2" ];
then
	echo "The current OpenWRT is running ${VERSION}. Please specify a newer one."
	exit 0
else
	echo "Start upgrading OpenWRT to ${VERSION}."
	sleep 6
fi

# Download necessary tools
apt-get install parted

# Download the lastest OpenWRT firmware
wget https://downloads.openwrt.org/releases/${VERSION}/targets/x86/64/openwrt-${VERSION}-x86-64-generic-ext4-combined.img.gz

# Uncompress it
gunzip openwrt-${VERSION}-x86-64-generic-ext4-combined.img.gz

# Copy it to the internal SSD
echo "The new firmware will be copied to /dev/sda, make sure you understand what you are doing."
sleep 6
dd if=openwrt-${VERSION}-x86-64-generic-ext4-combined.img of=/dev/sda bs=4M; sync;

# Resize the partition
parted /dev/sda resizepart 2 64G
resize2fs /dev/sda2 

echo "Upgrade to OpenWRT ${VERSION} completed!"
