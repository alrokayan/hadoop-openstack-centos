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

# Allow all Hadoop ports to be accessed from external
nova secgroup-add-rule default tcp 50010 50010 0.0.0.0/0
sleep 1
nova secgroup-add-rule default tcp 1004 1004 0.0.0.0/0
sleep 1
nova secgroup-add-rule default tcp 50075 50075 0.0.0.0/0
sleep 1
nova secgroup-add-rule default tcp 1006 1006 0.0.0.0/0
sleep 1
nova secgroup-add-rule default tcp 50020 50020 0.0.0.0/0
sleep 1
nova secgroup-add-rule default tcp 8020 8020 0.0.0.0/0
sleep 1
nova secgroup-add-rule default tcp 50070 50070 0.0.0.0/0
sleep 1
nova secgroup-add-rule default tcp 50470 50470 0.0.0.0/0
sleep 1
nova secgroup-add-rule default tcp 8021 8021 0.0.0.0/0
sleep 1
nova secgroup-add-rule default tcp 50030 50030 0.0.0.0/0
sleep 1
nova secgroup-add-rule default tcp 50060 50060 0.0.0.0/0

# show all
nova secgroup-list-rules myservers

