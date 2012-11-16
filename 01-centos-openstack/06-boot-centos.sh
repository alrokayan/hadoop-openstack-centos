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


# Create a VM instance from the CentOS image and inject the
# generated public key for password-less SSH connections
nova boot --image centos60 --flavor m1.xsmall --key_name centos_key hadoop-master
nova boot --image centos60 --flavor m1.xsmall --key_name centos_key hadoop-slave1
nova boot --image centos60 --flavor m1.xsmall --key_name centos_key hadoop-slave2
nova boot --image centos60 --flavor m1.xsmall --key_name centos_key hadoop-slave3
nova boot --image centos60 --flavor m1.tiny --key_name centos_key hadoop-client

# show VMs
nova list