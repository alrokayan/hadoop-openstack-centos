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
	echo "$1 hadoop-master" >> /etc/hosts
else
	echo "[[[[[ERROR]]]]] You must specify one argument - The Ip address of hadoop-master.
	
	You can get the IP address of the master VM by executing this command from OpenStack controller: . ~/show-IPs.sh"
fi

