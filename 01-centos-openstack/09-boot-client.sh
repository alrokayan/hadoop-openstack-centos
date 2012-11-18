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
	
	echo "nova boot --image centos60 --flavor $1 --key_name centos_key --hint force_hosts=$3 $2"
		
    # Create a VM instance from the CentOS image and inject the
	# generated public key for password-less SSH connections
	nova boot --image centos60 --flavor $1 --key_name centos_key --hint force_hosts=$3 $2
	
	# show the VM
	nova show $2
	
else
	if [ $# -eq 2 ]; then
    	# Create a VM instance from the CentOS image and inject the
		# generated public key for password-less SSH connections
		nova boot --image centos60 --flavor $1 --key_name centos_key $2
		
		# show the VM
		nova show $2
				
	else
		nova-manage instance_type list
		echo ''
		read -p 'Please input one of the above instance types name (example: m1.small): ' instance_type
		
		nova-manage service list
		echo ''
		echo 'You do not have to specify the compute host. If you kept it blank OpenStack scheduler will do it automatically. OpenStack is not data-intensive (Disk I/O) aware, so it is a good idea to distribute disk I/O load between the hosts.'
		read -p 'Please input one of the above compute host name to boot the CLIENT on (optional): ' compute_host
		
		#nova list
		#echo ''
		#read -p 'Please input the CLIENT host name other than what is above (hadoop-client): ' VM_name
		
		VM_name = "hadoop-client"
		
		if [ -z "$compute_host" ]; then
			echo "nova boot --image centos60 --flavor $instance_type --key_name centos_key $VM_name"
			nova boot --image centos60 --flavor $instance_type --key_name centos_key $VM_name
		else
			echo "nova boot --image centos60 --flavor $instance_type --key_name centos_key --hint force_hosts=$compute_host $VM_name"
			nova boot --image centos60 --flavor $instance_type --key_name centos_key --hint force_hosts=$compute_host $VM_name
		fi
	fi
fi