class cdh::metastore::install {

  package { ['hive-metastore', 'zookeeper-server', 'hive-server2', 'oozie']:
    ensure => present,
  }

}
