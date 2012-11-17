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


if [ $# -eq 3 ]
then
	echo "Forcing the VM to boot on compute host: $3"
	
	echo "nova boot --image hadoop-slave-image --flavor $1 --key_name centos_key --hint force_hosts=$3 $2"
	
    # Create a VM instance from the CentOS image and inject the
	# generated public key for password-less SSH connections
	nova boot --image hadoop-slave-image --flavor $1 --key_name centos_key --hint force_hosts=$3 $2
	
	# show VMs
	nova show $2
	
else
	if [ $# -eq 2 ]
	then
    	# Create a VM instance from the CentOS image and inject the
		# generated public key for password-less SSH connections
		nova boot --image hadoop-slave-image --flavor $1 --key_name centos_key $2
		
		# show VMs
		nova show $2
				
	else
		echo "[[[[[ERROR]]]]] You must specify three (or two) arguments - instance type, machine name, and compute host (optional).

		Example: . 12-add-slave-openstack\01-add-slave.sh m1.xsmall hadoop-slave2 compute1
	
		Example: . 12-add-slave-openstack\01-add-slave.sh m1.small hadoop-slave3

		You don not have to specify the compute host. If you passed only the first two arguments OpenStack scheduler will do it automatically. OpenStack is not data-intensive (Disk I/O) aware, so it is a good idea to distribute disk I/O load between the hosts."

		echo "You can get the instance types names from:"
		nova-manage instance_type list

		echo "You can get the compute host names from:"
		nova-manage service list
	fi
fi



