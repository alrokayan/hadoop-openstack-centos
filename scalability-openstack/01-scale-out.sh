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

# Export the variables defined in ../conf/configrc
. ../conf/configrc


if [ $# -eq 3 ]; then
	echo "Forcing the VM to boot on compute host: $3"
	
	echo "nova boot --image hadoop-slave-image --flavor $1 --key_name centos_key --availability-zone nova:$3 $2"
		
    # Create a VM instance from the CentOS image and inject the
	# generated public key for password-less SSH connections
	#nova boot --image hadoop-slave-image --flavor $1 --key_name centos_key --hint force_hosts=$3 $2
	nova boot --image hadoop-slave-image --flavor $1 --key_name centos_key --availability-zone nova:$3 $2

	
	# show the VM
	echo ''
	nova show $2
	
else
	if [ $# -eq 2 ]; then
    	# Create a VM instance from the CentOS image and inject the
		# generated public key for password-less SSH connections
		nova boot --image hadoop-slave-image --flavor $1 --key_name centos_key $2
		
		# show the VM
		echo ''
		nova show $2
				
	else
		# Show instance types (flavors)
		echo ''
		nova-manage instance_type list
		echo ''
		# Read instance types (flavors)
		read -p 'Please input one of the above instance types name (example: m1.small): ' instance_type
		
		# Show compute hosts
		echo ''
		nova-manage service list
		echo ''
		# Read compute hosts
		echo 'You do not have to specify the compute host. If you kept it blank OpenStack scheduler will do it automatically. OpenStack is not data-intensive (Disk I/O) aware, so it is a good idea to distribute disk I/O load between the hosts.'
		read -p 'Please input one of the above compute host name to boot the slave on (optional): ' compute_host
		
		# Show all running VMs
		echo ''
		nova list
		echo ''
		# Read new VM name
		read -p 'Please input a new slave host name other than what is above (hadoop-slave2): ' VM_name
		
		if [ -z "$compute_host" ]; then
			echo "nova boot --image hadoop-slave-image --flavor $instance_type --key_name centos_key $VM_name"
			nova boot --image hadoop-slave-image --flavor $instance_type --key_name centos_key $VM_name
		else
			echo "nova boot --image hadoop-slave-image --flavor $instance_type --key_name centos_key --availability-zone nova:$compute_host $VM_name"
			echo ''
			nova boot --image hadoop-slave-image --flavor $instance_type --key_name centos_key --availability-zone nova:$compute_host $VM_name

		fi
	fi
fi