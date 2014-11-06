class cdh::metastore::service {
  
  service { "hive-metastore":
    name        => 'hive-metastore',
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    subscribe   => File['/usr/lib/hive/conf/hive-site.xml']  
  }
  
}
