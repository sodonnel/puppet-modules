class cdh::metastore::service {
  
  service { "hive-metastore":
    name        => 'hive-metastore',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    subscribe   => File['/usr/lib/hive/conf/hive-site.xml']
  }

  ->

  service { "zookeeper-metastore":
    name        => 'zookeeper-server',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

  ->

  service { "hive2-server":
    name        => 'hive-server2',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    subscribe   => File['/usr/lib/hive/conf/hive-site.xml']
  }

}
