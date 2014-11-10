class cdh::datanode::service {


  service { "hadoop-hdfs-datanode":
    name        => 'hadoop-hdfs-datanode',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    subscribe   => [
                    File['/etc/hadoop/conf/hdfs-site.xml'],
                    File['/etc/hadoop/conf/core-site.xml'],
                    ]
                    
  }

  ->

  # On CENTOS 7, nodemanager doesn't start with systemctl command. It silently fails.
  # You need to run it with service start etc, hence the provider line.

  # TODO - does yarn really depend on all these files?
  service { "hadoop-yarn-nodemanager":
    name        => 'hadoop-yarn-nodemanager',
    provider    => 'redhat',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    subscribe   => [
                    File['/etc/hadoop/conf/core-site.xml'],
                    File['/etc/hadoop/conf/yarn-site.xml'],
                    File['/etc/hadoop/conf/mapred-site.xml'],
                    ]
  }
}
