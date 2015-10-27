# Boxes

There is vagrant config here to bring up different sorts of boxes, depending on requirements.

## Basic

This is a minimal Centos Box, running on 192.168.33.5, hostname basic. Nothing special is installed here.

## Hadoop

This is a pseudo-distributed Hadoop box running a recent version of CDH 5. This runs on 192.168.33.6, hostname standalone

## ldap_kerberos

This is very similar to the basic box, only openldap has been configured along with Kerberos. The ip is 192.168.33.9, hostname kerberos.example.com

## Cluster

This brings up a set of 4 machines on IPs 192.168.33.[5-8]. This allows simple clusters of machines to be created, however when the machines start nothing is running on tthem. The hostnames are cm, master, node1 and node2. The hosts file on each machine is setup to allow them to talk to each other via hostname.
