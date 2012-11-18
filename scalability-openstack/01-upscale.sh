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

# Export the variables defined in ../config/configrc
. ../config/configrc


if [ $# -eq 3 ]; then
	echo "Forcing the VM to boot on compute host: $3"
	
	echo "nova boot --image hadoop-slave-image --flavor $1 --key_name centos_key --hint force_hosts=$3 $2"
		
    # Create a VM instance from the CentOS image and inject the
	# generated public key for password-less SSH connections
	nova boot --image hadoop-slave-image --flavor $1 --key_name centos_key --hint force_hosts=$3 $2
	
	# show the VM
	nova show $2
	
else
	if [ $# -eq 2 ]; then
    	# Create a VM instance from the CentOS image and inject the
		# generated public key for password-less SSH connections
		nova boot --image hadoop-slave-image --flavor $1 --key_name centos_key $2
		
		# show the VM
		nova show $2
				
	else
		nova-manage instance_type list
		echo ''
		read -p 'Please input one of the above instance types name: ' instance_type
	fi
fi