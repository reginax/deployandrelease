#!/bin/sh
# just an example of what to do... works on our redhat vms...
cd /tmp
wget http://mirror-fpt-telecom.fpt.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
yum install epel-release-6-8.noarch.rpm
yum -y install python-pip
python-pip install solrpy
