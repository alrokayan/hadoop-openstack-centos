A Step-by-Step Guide to Installing Hadoop on OpenStack CentOS VMs with Eclipse Hadoop plugin
=====================================================================================================================

Project Information
-------------------
-	Script license: Apache
-	Hadoop version: Hadoop 0.2
-	MapReduce version: MRv1
-	Binaries source for CentOS: Cloudera CDH4
-	Java version: Sun Java 1.6
-	OpenStack Installation: https://github.com/alrokayan/openstack-centos-kvm-glusterfs

Installation Steps
-------------------
Steps to install Hadoop on CentOS VMs on OpenStack:

(1)	Install OpenStack
(2)	Open new terminal (OpenStackTerminal) and login to your OpenStack Controller
(3)	From OpenStackTerminal, execute:

::

	yum install -y git
	git clone https://github.com/alrokayan/hadoop-openstack-centos.git
	cd hadoop-openstack-centos

(4)	From OpenStackTerminal, edit ``config\configrc`` file to match your OpenStack setup
(5)	From OpenStackTerminal, execute "01-centos-openstack" folder
(6)	Open three new terminals (MasterTerminal, SlaveTerminal, and ClientTerminal) for the VMs and login to your controller form all the three terminals.
(7)	From MasterTerminal login to your master node

::

	cd hadoop-openstack-centos
	. 01-centos-openstack/07-show-IPs.sh
	. 01-centos-openstack/08-ssh-into-vm.sh <IP ADDRESS FOR THE MASTER FROM THE PERVIOUS COMMAND>
(8)	From SlaveTerminal login to your slave node

::
	cd hadoop-openstack-centos
	. 01-centos-openstack/07-show-IPs.sh

	. 01-centos-openstack/08-ssh-into-vm.sh <IP ADDRESS FOR SLAVE FROM THE PERVIOUS COMMAND>

(9)	From ClientTerminal login to your client node

::
	cd hadoop-openstack-centos
	. 01-centos-openstack/07-show-IPs.sh
	. 01-centos-openstack/08-ssh-into-vm.sh <IP ADDRESS FOR CLIENT FROM THE PERVIOUS COMMAND>

(10)	From the three VM terminals (MasterTerminal, SlaveTerminal, and ClientTerminal), execute: 

::
	yum install -y git
	git clone https://github.com/alrokayan/hadoop-openstack-centos.git
	cd hadoop-openstack-centos
-	From the three VM terminals (MasterTerminal, SlaveTerminal, and ClientTerminal), execute "02-cloudera-cdh-allVMs" folder
-	From MasterTerminal, execute "03-install-master" folder
-	From SlaveTerminal, execute "04-install-slave" folder
-	From ClientTerminal, execute "05-install-client" folder
-	From the three terminals (MasterTerminal, SlaveTerminal, and ClientTerminal), edit "config\core-site.xml", "config\hdfs-site.xml", "config\mapred-site.xml", and "config\hosts" according to 01-centos-openstack execution result
-	From the three terminals (MasterTerminal, SlaveTerminal, and ClientTerminal), execute "06-config-allVMs" folder
-	From OpenStackTerminal, excute "07-slave-image" folder
-	From OpenStackTerminal, keep executing "07-slave-image/02-show-images.sh" untile you see the status of "hadoop-slave-image" is ACTIVE (it will take long time, just wait, do not go to the next step before it got ACTIVE)
-	From MasterTerminal, execute "08-start-master" folder
-	From SlaveTerminal, execute "09-start-slave" folder
-	From ClientTerminal, execute "10-start-client" folder

Eclipse Plugin Steps
---------------------
To use Eclipse plugin (which acts as client) and test your setup, follow those steps:


-	Download Eclipse Classic: http://www.eclipse.org/downloads/

-	Download Hadoop Eclipse Plugin from the last section in this page: http://code.google.com/edu/parallel/tools/hadoopvm/index.htm and follow the steps there with the following settings:
::
	Hostname: <MASTER VM HOST IP ADDRESS>
	Installtion directory: /usr/lib/hadoop
	Username: root
	Password: <MASTER VM PASSWORD>
-	Download hadoop Jars: http://hadoop.apache.org/releases.html#Download and uncompress it, then place it in your home directory or in C:\ or anywhere you like.

-	Open Eclipse then choose: File->New->Project->MapReduce Project

-	Put any project name, then click "Configure Hadoop install directory…", then cleck "Browse..." and select you uncompressed hadoop folder, ex: /Users/alrokayan/hadoop-0.22.0. Apply->OK->Finish.

-	Drag the three .java files in the "Eclipse-Example" folder (WordCountDriver.java, WordCountMap.java, and WordCountReduce.java) into the "src" folder (not the project it self) in Eclipse. Select copy, then press OK.

-	Login to your client, from OpenStack controller:
1.	Execute:
::
	. 01-centos-openstack/07-show-IPs.sh
	. 01-centos-openstack/08-ssh-into-vm.sh <IP ADDRESS FOR THE CLIENT>
2.	After you login to the client VM:
2.1.	touch text
2.2.	
::
	echo "test
	yes
	hadoop
	test
	no
	test
	no
	test
	" > text
2.3.	Execute:
::
	hadoop fs –copyToLocal text /user/root/text

-	Keep Hadoop client terminal open, and from Eclipse: right-click on WorkCountDriver.java -> Run As -> Run On Hadoop -> Select your server or defind a new one

-	From Hadoop client, execute: hadoop fs -cat /user/root/output/part-00000, you should see:
::
	hadoop	1
	no	2
	test	4
	yes	1


Add More Slave Nodes
--------------------
From OpenStack Controller
^^^^^^^^^^^^^^^^^^^^^^^^^

To add more slave nodes you need to execute "11-add-slave-openstack\01-add-slave.sh" and passing three arguments: instance_type, machine_name, and compute_host (optional).

You don not have to specify the computer host. If you passed only the first two arguments OpenStack scheduler will do it automatically. OpenStack is not data-intensive (Disk I/O) aware, so maybe you want to distribute disk I/O load between the hosts.

You can get a list of compute nodes by executing this command:
::
	nova-manage service list
You can get a list of current instance types by executing this command:
::
	nova-manage instance_type list
You can add new instance type by executing this command:
::
	nova-manage instance_type create m1.xsmall 1024 1 10 0 0 0
Where 1024 is the memory size, 1 is the number of cores (VCPU), and 10 is the hard disk space.


Verification
^^^^^^^^^^^^^

You can verify if the node has been added by first check if the VM is ACTIVE by executing this command from OpenStack controller:
::
	nova list
If the VM is ACTIVE, login to the client VM by executing this command:
::
	. 01-centos-openstack/07-show-IPs.sh
	. 01-centos-openstack/08-ssh-into-vm.sh <IP ADDRESS FOR THE CLIENT>
From the client VM execut this command to see how many Data Nodes are running:
::
	sudo -u hdfs hadoop dfsadmin -report


Troubleshooting
----------------
*Error:* org.apache.hadoop.mapred.FileAlreadyExistsException

*Solution:* Two Solutions (choose one):

-	Login to your client then delete the output folder by executing the following command:
::
	hadoop fs -rmr /user/root/output
-	Rename the output folder form WorkCountDriver.java by replace "/user/root/output" with "/user/root/output1".