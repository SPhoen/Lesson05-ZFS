#!/bin/bash

# Add repos
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Prepare YUM
#yum update -y 
yum install -y yum-utils

# Install ZFS part
yum install -y https://zfsonlinux.org/epel/zfs-release.el8_5.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinux
yum-config-manager --enable zfs-kmod
yum-config-manager --disable zfs
yum install -y zfs
# End =============

# Load module to  kermnel
modprobe zfs
# End ===================

#install wget
yum install -y wget
# END =======
