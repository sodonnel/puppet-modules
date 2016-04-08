# Puppet and Vagrant Scripts

This is a collection of puppet modules I have build up over some time, used mainly to build Cloudera Hadoop Virtual machines at various versions. I don't consider these puppet-modules production ready - in other words, I use them with Vagrant to build VMs on my local system, but if you want to run a production cluster, Cloudera Manager is a much better solution.

## Setup

These scripts require a little bit of setup before they can be used.

1) Install [Virtualbox 5.0.x](https://www.virtualbox.org/wiki/Downloads) - other versions may work, but I tested on 5.0.14

2) Install [Vagrant](https://www.vagrantup.com/downloads.html) - I have tested with 1.7.4

3) Download my base box for vagrant and install it. This box has a unix account vagrant, password vagrant. The root password is also vagrant, but the vagrant user has passwordless sudo setup, so it can do basically anything anyway. Some developer tools and Puppet are also installed on the base box.

The box is on Google Drive - [download it](https://drive.google.com/open?id=0B_FGhp1HZfFfbVJKS1RLaDVwc2c) and then install the download into vagrant:

vagrant box --name base-box add ~/Downloads/centos-6.7-base.box

It is import the box is named base-box in vagrant. Check the output of the following command looks like this:

    $ vagrant box list
    base-box       (virtualbox, 0)

4) Clone this git repo

5) There are two rpms that need to be downloaded and placed into the rpms directory inside this git repo:

 * [javajdk-1.7.0-79.x86_64.rpm](https://drive.google.com/file/d/0B_FGhp1HZfFfLXl3Y0xMaW9VU3M/view?usp=sharing)
 * [sqoopjdbc-1.0.0-1.x86_64.rpm](https://drive.google.com/open?id=0B_FGhp1HZfFfUUo4RmQ5SXdnNnc)

The first puts Java 1.7.0-79 onto the box and the other install the Sqoop JDBC driver for mysql.

The rpms directory should look like:

    $ ls -1
    javajdk-1.7.0-79.x86_64.rpm
    sqoopjdbc-1.0.0-1.x86_64.rpm

That should be the setup down.

## The Box Environment

Virtual box provides a internal host only network, and the machines started by these scripts will create boxes that have IP addresses 192.168.33.x. The first time you attempt to start any boxes, you may get a security prompt on your system so Virtual box can install that local network.

All the boxes are created with two network interfaces - one is a NAT adapter that allows the box to reach the internet via your laptops network connection. The other is a host only adapter, that allows the Virtual box instances to talk to each other on that network, and also for you to ssh onto the boxes from the host (your laptop).

I have run these boxes on machines with 16GB and 12GB of RAM, and they seem to work well. I suspect you will need at least 8GB on the host for the Hadoop VM, but 16 would be better.

## Boxes

Inside boxes directory, are a series of sub directories that correspond to different boxes. The sub directories that make up these boxes are listed below, along with some information around how to use them. All that is inside each directory is a single file - Vagrantfile. This contain the configuration of the box, such as its IP address, memory and any build scripts. This file is used by Vagrant to boot the box.

All the boxes start 'headless' - you can either ssh onto the box using normal ssh to its IP address. All boxes have the user vagrant with a password of vagrant. Alternatively, when in the box directory, you can ssh onto the box using the command below without a password:

    $ vagrant ssh

For all boxes you can build (or restart if they were previously built) them with the following command:

    $ vagrant up

If the box has not been built before, vagrant will install it into Virtual box, start it up and depending on the box run puppet to build it. To shutdown the box:

    $ vagrant halt

To destroy the box, removing it completely from your system:

    $ vagrant destroy

All boxes also have a two mount points created that allow the VM to access the host filesystem. The directory /vagrant always maps to the local directory containing the Vagrantfile you started the box from, eg:

    this_git_repo/boxes/basic

The root of this git repo is also mapped onto the box as /puppet_modules. You can add more directories easily enough - just look at the vagrant files where /puppet_modules is defined, then halt the box

### Basic

The is the most simple box, giving you a basic Centos 6.6 install with 512MB RAM. It runs on IP 192.168.33.5, and there are no puppet scripts applied to it.

### Hadoop

This is the most complicated box, as it allows you to build a Pseudo Distributed Hadoop Cluster at various versions of Cloudera Hadoop (CDH). I have tested builds with CDH 5.3.x, 5.4.x and 5.5.x. The box runs on 192.168.33.6 and has a hostname of standalone. If you switch into this directory, and run `vagrant up`, it will build a cluster with CDH 5.5.1. However, if you set the environment variable CDH_VERSION to a different version, it will be used instead:

    $ export CDH_VERSION=5.4.5

A cluster can also be built that is Kerberos secured - the KDC is installed on the same VM, and has an admin password of 'vagrant' - to build a secured version, you prefix the CDH_VERSION variable with the character 's':

    $ export CDH_VERSION=s5.4.5

Sometimes you want to have two builds of the same Hadoop version installed on your system at the same time - to allow that, you can add a machine name to the CDH_VERSION:

    $ export CDH_VERSION=s5.4.5_secure_test_1

Note that when you build a box by setting a CDH_VERSION, you must always ensure the correct environment variable is set if you run `vagrant ssh|halt|up` otherwise Vagrant will attempt to operate on the wrong box. If you have a few Hadoop versions around, then it can be easy to forget what you have, so you can use the command `vagrant global-status` to list everything vagrant controls on your system:

    $ vagrant global-status

    id       name                      provider   state    directory                                                  
    ------------------------------------------------------------------------------------------------------------------
    7998f09  default                   virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/hadoop        
    b6bbbf6  default                   virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/oracle        
    5641146  cdh_5.4.7                 virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/hadoop        
    af42498  cdh_5.5.1                 virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/hadoop        
    0234ad4  cdh_secure_5.4.8          virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/hadoop        
    7c6f772  cdh_5.5.1_test            virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/hadoop        
    cd884cf  cdh_secure_5.5.1_sentry   virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/hadoop        
    426483d  cdh_secure_5.5.1          virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/hadoop        
    f80a532  cdh_5.5.1_clean           virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/hadoop        
    2aa585f  cdh_secure_5.5.1_fqdntest virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/hadoop        
    42de25d  default                   virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/basic         
    97df082  cdh_5.4.4                 virtualbox poweroff /Users/sodonnell/source/puppet-modules/boxes/hadoop

If I wanted to start cdh_5.5.1_test, I would set `export CDH_VERSION=5.5.1_test`, or if I wanted to start the secure 5.4.8 version, I would set `export CDH_VERSION=s5.4.8`.

If you start the VM, and want to browse to the Namenode WebUI, for example, you can use your normal web browser and goto `http://192.168.33.6:50070`. Another idea is to set the hostname standalone to 192.168.33.6 in your hosts file.

#### Components

The following componets are installed on the VM, and I've tested them in some way:

* HDFS
* YARN
* Hive Metastore in Mysql
* Hive
* Hiveserver2
* Oozie (database in Mysql)
* HBase
* Solr
* Sqoop (with the Mysql driver installed)
* Zookeeper
* Hue
* MIT Kerberos (if running secured)
* Mysql - root password is root123


#### Limitations

* You cannot run two Hadoop boxes at the same time
* The secondary namenode isn't configured, so checkpoint won't happen
* Anything related to HA is obviously not avaiable
* RPMs are used to install Hadoop - not parcels
* Cloudera Manager is not used or installed
* I have seen problems when logged into a VM access the 192.168.33.x IP addresses in the hosts web browser. There is probably something that can be changed in the VPN settings, but I have not looked into it.

### Cluster (Hadoop Cluster)

This is still under development - the aim is to get it to a point where you can start a real distributed cluster across 5 VMs - one as the master node (Namenode, Resource Manager, Hive Metastore etc) and 4 datanodes. Ideally it should allow the Hadoop version to be selected in the same way as the Hadoop box, and allow it to be secured or unsecured.

Right now, it will only start unsecured CDH 5.5.1 on a couple of nodes. I will update this section with more information when the 'Cluster' box is ready to be used by anyone except me. 

### Oracle

This box requires a different base box which is not published anywhere right now, and so cannot really be used.

This startups up a VM running Oracle 12cR1 on IP address 192.168.33.8, with 1792MB RAM. No puppet modules are installed, as Oracle is pre-installed on the base box. The best wa to use it is to switch to the Oracle user and connect to Oracle as sysdba, then create whatever you need.

