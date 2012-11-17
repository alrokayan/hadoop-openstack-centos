A Step-by-Step Guide to Install Hadoop on OpenStack CentOS VMs and Run Jobs via Eclipse Hadoop Plugin
=====================================================================================================================

Project Information
-------------------
-	Script license: Apache
-	Hadoop version: Hadoop 0.2
-	MapReduce version: MRv1
-	Binaries source for CentOS: Cloudera CDH4
-	Java version: Sun Java 1.6

Installation Steps
-------------------
Steps to install Hadoop on OpenStack CentOS VMs:

(1)	Install OpenStack: https://github.com/alrokayan/openstack-centos-kvm-glusterfs.
(2)	Open new terminal (*OpenStackTerminal*) and login to your OpenStack Controller.
(3)	From *OpenStackTerminal*, execute:

::

	yum install -y git
	git clone https://github.com/alrokayan/hadoop-openstack-centos.git
	cd hadoop-openstack-centos
(4)	From *OpenStackTerminal*, edit ``config\configrc`` file to match your OpenStack setup.
(5)	From *OpenStackTerminal*, execute ``01-centos-openstack`` folder. Please note that ``01-centos-openstack\07-boot-centos-VMs.sh`` takes three arguments, which are the OpenStack compute host names for master, slave, then client. ``01-centos-openstack\06-show-hosts.sh`` will show you a list of OpenStack compute host names.
(6)	Open three new terminals (*MasterTerminal*, *SlaveTerminal*, and *ClientTerminal*) for the VMs and login to your controller form all the three terminals. Now you should have 4 terminals - all logged into OpenStack controller.
(7)	From *MasterTerminal* login to your master node, by executing:

::

	. ~/show-IPs.sh
	. ~/ssh-into-vm.sh <IP ADDRESS FOR THE MASTER FROM THE PERVIOUS COMMAND>
(8)	From *SlaveTerminal* login to your slave node, by executing:

::

	. ~/show-IPs.sh
	. ~/ssh-into-vm.sh <IP ADDRESS FOR SLAVE FROM THE PERVIOUS COMMAND>
(9)	From *ClientTerminal* login to your client node, by executing:

::

	. ~/show-IPs.sh
	. ~/ssh-into-vm.sh <IP ADDRESS FOR CLIENT FROM THE PERVIOUS COMMAND>
(10)	From the three VM terminals (*MasterTerminal*, *SlaveTerminal*, and *ClientTerminal*), execute: 

::

	yum install -y git
	git clone https://github.com/alrokayan/hadoop-openstack-centos.git
	cd hadoop-openstack-centos

(11)	From the three VM terminals (*MasterTerminal*, *SlaveTerminal*, and *ClientTerminal*), execute ``02-cloudera-cdh-allVMs`` folder.
(12)	From *MasterTerminal*, execute ``03-install-master`` folder.
(13)	From *SlaveTerminal*, execute ``04-install-slave`` folder.
(14)	From *ClientTerminal*, execute ``05-install-client`` folder.
(15)	From the three terminals (*MasterTerminal*, *SlaveTerminal*, and *ClientTerminal*), execute ``6-config-allVMs`` folder.
(16)	From *MasterTerminal*, execute ``07-start-master`` folder.
(17)	From *SlaveTerminal*, execute ``08-start-slaves`` folder.
(18)	From *ClientTerminal*, execute ``09-start-client`` folder.
(19)	From *OpenStackTerminal*, execute ``10-save-slave-image-openstack`` folder.
(20)	From *OpenStackTerminal*, keep executing ``10-save-slave-image-openstack/02-show-images.sh`` until you see the status of ``hadoop-slave-image`` is ACTIVE (it may take long time, just wait, do not go to the next step before it got ACTIVE).
(21)	From *OpenStackTerminal*, execute ``11-forward-webUI-openstack`` folder. Please note If you see any iptables entry after you execute ``11-forward-webUI-openstack\01-check-ports.sh``, please edit '/etc/sysconfig/iptables' and remove those lines, then run ``11-forward-webUI-openstack\01-check-ports.sh`` again (the script will restart the iptables) ... DO NOT go to the next step before deleting those entries if there is any.

Execute Hadoop Job From Eclipse Plugin
--------------------------------------
Eclipse can be installed inside an OpenStack VM (Other than the VMs that we have provisioned above), or just use your personal computer that can access the Master node directly. To use your personal computer, you must be able to ssh to the Master directly, not via OpenStack controller. What I do is just plug my personal computer to the same OpenStack switch. However, if you can not jump to next section, which is *"Execute Hadoop Job From Hadoop Client VM"*.

To use Eclipse plugin (which acts as another Hadoop client) and test your setup, follow those steps:

(1)	Download Eclipse Classic: http://www.eclipse.org/downloads/.
(2)	Download *Hadoop Eclipse Plugin* from the last section in this page: http://code.google.com/edu/parallel/tools/hadoopvm/ and follow the steps there with the following settings:

::

	Hostname: <MASTER VM HOST IP ADDRESS>
	Installation directory: /usr/lib/hadoop
	Username: root
	Password: <MASTER VM PASSWORD>
(3)	Download Hadoop Jars: http://hadoop.apache.org/releases.html#Download and uncompress it, then place it in your home or C:\\ directory, or anywhere you like.
(4)	Open Eclipse then choose: File -> New -> Project -> *MapReduce Project*.
(5)	Put any project name, then click ``Configure Hadoop install directory…``, then click ``Browse...`` and select your uncompressed Hadoop Jars folder, example: /Users/alrokayan/hadoop-0.22.0, then click Apply -> OK -> Finish.
(6)	Drag (or copy-and-past) the three .java files from ``Eclipse-Example`` folder (``WordCountDriver.java``, ``WordCountMap.java``, and ``WordCountReduce.java``) into the ``src`` folder (not the project it self) in Eclipse, then choose copy, then press OK.
(7) From OpenStack controller, make sure that the ``config\configrc`` file has the correct values for your OpenStack setup.
(8)	From OpenStack controller, execute :

::

	. ~/show-IPs.sh
	. ~/ssh-into-vm.sh <IP ADDRESS FOR THE CLIENT>

(9) After you login to the client VM, execute:

::

	touch text

	echo "test
	yes
	hadoop
	test
	no
	test
	no
	test
	" > text
	
	hadoop fs –copyFromLocal text /user/root/text

(10)	Keep Hadoop client terminal open, and from Eclipse: right-click on WorkCountDriver.java -> Run As -> Run On Hadoop -> Select your server (or define a new one, see step 2 above for the settings)

(11)	From Hadoop client, execute:

::

	hadoop fs -cat /user/root/output/part-00000

You should see:

::

	hadoop	1
	no	2
	test	4
	yes	1



Execute Hadoop Job From Hadoop Client VM 
-----------------------------------------
We will use Eclipse to develop the application then export it as Jar to be ready for execution from a Hadoop Client VM. This is an *alternative* method to the previous section: "Execute Hadoop Job From Eclipse Plugin". Steps are as follows:

(1)	Download Eclipse Classic: http://www.eclipse.org/downloads/.
(2)	Download *Hadoop Eclipse Plugin* from the last section in this page: http://code.google.com/edu/parallel/tools/hadoopvm/ and follow the steps there ignoring the second part where you add a new Hadoop server.
(3)	Download Hadoop Jars: http://hadoop.apache.org/releases.html#Download and uncompress it, then place it in your home or C:\\ directory, or anywhere you like.
(4)	Open Eclipse then choose: File -> New -> Project -> *MapReduce Project*.
(5)	Put any project name, then click ``Configure Hadoop install directory…``, then click ``Browse...`` and select your uncompressed Hadoop Jars folder, example: /Users/alrokayan/hadoop-0.22.0, then click Apply -> OK -> Finish.
(6)	Drag (or copy-and-past) the three .java files from ``Eclipse-Example`` folder (``WordCountDriver.java``, ``WordCountMap.java``, and ``WordCountReduce.java``) into the ``src`` folder (not the project it self) in Eclipse, then choose copy, then press OK.
(7) Right-click on the project name -> Export -> JAR file -> Next
(8) Click the ``Browse`` button to specify the location of the exported Jar file. Put it anywhere where you can move it to the client VM. What I do is put it in the public folder of Dropbox so I can download it (wget it) from the client VM. Don not forget to add .jar at the end. Mine looks like this: /Users/alrokayan/Dropbox/Public/Hadoop_JARs/WordCount.jar. Ignore the warnings.
(9) From OpenStack controller, make sure that the ``config\configrc`` file has the correct values for your OpenStack setup.
(10)	From OpenStack controller, execute :

::

	. ~/show-IPs.sh
	. ~/ssh-into-vm.sh <IP ADDRESS FOR THE CLIENT>

(11) After you login to the client VM, execute:

::

	touch text

	echo "test
	yes
	hadoop
	test
	no
	test
	no
	test
	" > text
	
	hadoop fs -copyFromLocal text /user/root/text

(12)	From Hadoop client, download the jar file. Replace the link with your public dropbox link (or whatever method do you use to move the jar file to the client VM):

::

	wget https://dl.dropbox.com/u/98652/Hadoop_JARs/WordCount.jar

(13)	Execute the job without specifying the input and output (We have defined them in WordCountDriver class)

::

	hadoop jar WordCountA.jar WordCountDriver
	
Or you can set the input and output

::

	hadoop jar WordCountA.jar WordCountDriver /user/root/text /user/root/output

Note: the input can be file or folder with many files

(14)	From Hadoop client, execute:

::

	hadoop fs -cat /user/root/output/part-00000

You should see:

::

	hadoop	1
	no	2
	test	4
	yes	1



Add More Slave Nodes
--------------------
From OpenStack Controller
^^^^^^^^^^^^^^^^^^^^^^^^^

To add more slave nodes you need to execute ``12-add-slave-openstack\01-add-slave.sh`` and passing three arguments: ``instance_type``, ``machine_name``, and ``compute_host`` (optional).

Examples:

::

	. 12-add-slave-openstack\01-add-slave.sh m1.xsmall hadoop-slave2 compute1
	
::

	. 12-add-slave-openstack\01-add-slave.sh m1.small hadoop-slave3

You don not have to specify the ``compute_host``. If you passed only the first two arguments OpenStack scheduler will do it automatically. OpenStack is not data-intensive (Disk I/O) aware, so it is a good idea to distribute disk I/O load between the hosts manually.

You can get a list of *compute nodes* by executing this command:
::
	nova-manage service list
You can get a list of current *instance types* by executing this command:
::
	nova-manage instance_type list
You can add new *instance type* by executing this command:
::
	nova-manage instance_type create m1.xsmall 1024 1 10 0 0 0
Where ``1024`` is the memory size, ``1`` is the number of cores (VCPU), and ``10`` is the disk space.


Verification
^^^^^^^^^^^^^

You can verify if the slave node has been added by first check if the slave VM is ACTIVE by executing this command from OpenStack controller:

::

	nova list
	
If the VM is ACTIVE, login to the client VM by executing this command:

::

	. ~/show-IPs.sh
	. ~/ssh-into-vm.sh <IP ADDRESS FOR THE CLIENT>
	
From the client VM execute this command to see if the new salve (Data Node) is running:

::

	sudo -u hdfs hadoop dfsadmin -report
	

Web UI Monitoring
-----------------
You can monitor Hadoop using two Web UI:
(1) MapReduce Monitoring via Master JobTracker:

::

	http://<OpenStack Controller IP/Hostname>:50070

(2) HDFS Monitoring and browsing the files via Master NameNode:

::

	http://<OpenStack Controller IP/Hostname>:50030



Troubleshooting
----------------
*Error:*

::

	org.apache.hadoop.mapred.FileAlreadyExistsException

*Solutions:* (choose one of the two solutions):

-	Login to your client then delete the ``output`` (or what ever the name was) folder by executing the following command:

::

	hadoop fs -rm -r /user/root/output
-	Rename the output folder. For example: form WorkCountDriver.java by replace ``/user/root/output`` with ``/user/root/output1``.


-------

*Error:*

::
	
	–copyFromLocal: Unknown command  

*Error:*

::
	
	-cat: Unknown command

*Solution:* Retype the hyphen (-) from your keyboard in your terminal.

--------

*Error:*

::

	ERROR security.UserGroupInformation: PriviledgedActionException as:root

*Solution:* Delete all folders in HDFS then execute ``07-start-master/03-hdfs-system-folders.sh`` again. To delete folders in HDFS execute:

::

	sudo -u hdfs hadoop fs -rm -r /user
	sudo -u hdfs hadoop fs -rm -r /var
	sudo -u hdfs hadoop fs -rm -r /tmp

----------

*Error:*

::
	
	copyToLocal: `/user/root/text': No such file or directory

*Solution:* check if you want "copyToLocal" or "copyFromLocal", then ``ls`` local and HDFS folder. To ``ls`` HDFS do:

::

	hadoop fs -ls /path/to/folder



Sources
-------
- Cloudera CDH4 Installation Guide: https://ccp.cloudera.com/display/CDH4DOC/CDH4+Installation+Guide
- DAK1N1 Blog: http://dak1n1.com/blog/9-hadoop-el6-install