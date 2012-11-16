#!/bin/sh

# Copyright 2012 Mohammed Alrokayan
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Install wget
yum install wget -y

# Download CentOS image
mkdir /tmp/images
cd /tmp/images
wget http://c250663.r63.cf1.rackcdn.com/centos60_x86_64.qcow2

# Add CentOS image to Glance
glance add name="centos60" is_public=true disk_format=qcow2 container_format=bare < centos60_x86_64.qcow2

# Remove the temporary directory
rm -rf /tmp/images

# Show image
glance index