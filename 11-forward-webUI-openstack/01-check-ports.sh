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

# Show iptables entries
cat /etc/sysconfig/iptables | grep 50070
cat /etc/sysconfig/iptables | grep 50030

# Display message
echo "If you see any iptables entry above this message, please edit '/etc/sysconfig/iptables' and remove those lines, then run: 'service iptables restart' ... DO NOT go to the next step before deleting those entries if there is any"