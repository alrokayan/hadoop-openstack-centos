A Step-by-Step Guide to Installing Hadoop on OpenStack CentOS VMs and use Eclipse
=====================================================================================================================

Installation Steps
-------------------
Steps to install Hadoop on CentOS VMs on OpenStack:

1) Install OpenStack
2) Edit "config\configrc" file to match your OpenStack setup
3) Execute "01-centos-openstack" folder
4) Edit "config\core-site.xml", "config\hdfs-site.xml", "config\mapred-site.xml", and "config\hosts" according to 01-centos-openstack execution
5) Execute "02-cloudera-cdh-allVMs" on all VMs
6) Execute "03-install-master" on the master VM
7) Execute "04-install-slave" on all slave VMs
8) Execute "05-install-client" on a client VM.
9) Execute "06-config-allVMs" on all VMs
10) Execute "07-start-master" on the master VM
11) Execute "08-start-slave" on all slave VMs
12) Execute "09-start-client" on a client VM

Eclipse Plugin Steps
---------------------
To use Eclipse plugin (which acts as client) and test your setup, follow those steps:


1.	Download Eclipse Classic: http://www.eclipse.org/downloads/

2.	Download Hadoop Eclipse Plugin from the last section in this page: http://code.google.com/edu/parallel/tools/hadoopvm/index.htm and follow the steps there with the following settings:
::
	Hostname: <MASTER VM HOST IP ADDRESS>
	Installtion directory: /usr/lib/hadoop
	Username: root
	Password: <MASTER VM PASSWORD>
3.	Download hadoop Jars: http://hadoop.apache.org/releases.html#Download and uncompress it, then place it in your home directory or in C:\ or anywhere you like.

4.	Open Eclipse then choose: File->New->Project->MapReduce Project

5) Put any project name, then click "Configure Hadoop install directory…", then cleck "Browse..." and select you uncompressed hadoop folder, ex: /Users/alrokayan/hadoop-0.22.0. Apply->OK->Finish.

6) Drag the three .java files in the "Eclipse-Example" folder (WordCountDriver.java, WordCountMap.java, and WordCountReduce.java) into the "src" folder (not the project it self) in Eclipse. Select copy, then press OK.

7) Login to your client, from OpenStack controller:
7.1) Execute:
::
	. 01-centos-openstack/07-show-IPs.sh
7.2) Execute:
::
	. 01-centos-openstack/08-ssh-into-vm.sh <IP ADDRESS FOR THE CLIENT>
7.3) After you login to the client VM:
7.3.1) touch text
7.3.2)
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
7.3.3) Execute:
::
	hadoop fs –copyToLocal text /user/root/text

8) Keep Hadoop client terminal open, and from Eclipse: right-click on WorkCountDriver.java -> Run As -> Run On Hadoop -> Select your server or defind a new one

6) From Hadoop client, execute: hadoop fs -cat /user/root/output/part-00000, you should see:
::
	hadoop	1
	no	2
	test	4
	yes	1


Troubleshooting
----------------
*Error:* org.apache.hadoop.mapred.FileAlreadyExistsException

*Solution:* Two Solutions (choose one):

1) Login to your client then delete the output folder by executing the following command:
::
	hadoop fs -rmr /user/root/output
2) Rename the output folder form WorkCountDriver.java by replace "/user/root/output" with "/user/root/output1".