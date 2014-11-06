class cdh::datanode::service {


  service { "hadoop-hdfs-datanode":
    name        => 'hadoop-hdfs-datanode',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

  ->

  # On CENTOS 7, nodemanager doesn't start with systemctl command. It silently fails.
  # You need to run it with service start etc, hence the provider line.
  service { "hadoop-yarn-nodemanager":
    name        => 'hadoop-yarn-nodemanager',
    provider    => 'redhat',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }
}
