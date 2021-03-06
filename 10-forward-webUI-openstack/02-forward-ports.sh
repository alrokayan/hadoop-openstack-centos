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

if [ $# -eq 1 ]
then
	# Add entries to iptables
	iptables -t nat -A PREROUTING -p tcp --dport 50070 -j DNAT --to $1:50070
	iptables -t nat -A PREROUTING -p tcp --dport 50030 -j DNAT --to $1:50030

else
    # Export the variables defined in ../conf/configrc
	. ../conf/configrc
	
	nova list
	
    echo ''
    read -p 'From the above VMs what is the IP address of the MASTER node? ' master_node
    
    # Add entries to iptables
	iptables -t nat -A PREROUTING -p tcp --dport 50070 -j DNAT --to $master_node:50070
	iptables -t nat -A PREROUTING -p tcp --dport 50030 -j DNAT --to $master_node:50030
fi

# Allow IPv4 forward
sysctl net.ipv4.ip_forward=1

# Save and reset iptables
service iptables save
service iptables restart

# Show the entries to iptables
cat /etc/sysconfig/iptables | grep 50070
cat /etc/sysconfig/iptables | grep 50030
