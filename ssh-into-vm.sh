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


# SSH into a VM instance using the generated test.pem key.

if [ $# -eq 1 ]
then
	ssh -i centos_key.pem -l root $1
else
	# Export the variables defined in ~/hadoop-openstack-centos/config/configrc
	. configrc

	# show VMs
	nova list
    echo ''
    read -p 'From the above VMs what is the IP address of the VM to ssh to? ' master_node
    
    ssh -i centos_key.pem -l root $master_node
fi


