#!/bin/bash

set -e

rm -f /etc/kafka/conf/*.keytab

kadmin -p root/admin -w vagrant -q "delprinc -force kafka/$(hostname)"
kadmin -p root/admin -w vagrant -q "delprinc -force zookeeper/$(hostname)"

kadmin -p root/admin -w vagrant -q "addprinc -randkey kafka/$(hostname)"
kadmin -p root/admin -w vagrant -q "addprinc -randkey zookeeper/$(hostname)"

kadmin -p root/admin -w vagrant -q "xst -k /etc/kafka/conf/kafka.keytab kafka/$(hostname)"

chmod 644 /etc/kafka/conf/kafka.keytab

touch /root/kafka_keytabs_generated
