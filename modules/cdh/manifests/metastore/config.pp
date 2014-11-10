class cdh::metastore::config {

  exec {'hive-user':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir -p /user/hive/warehouse',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user/hive/warehouse',
    timeout   => 0,
  }

  ->

  exec {'hive-user-permissions':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chmod -R 1777 /user/hive',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user | grep /user/hive | grep drwxrwxrwt',
    timeout   => 0,
  }

  ->

  file { [ '/var/lib/zookeeper' ]:
    ensure => "directory",
    owner  => 'zookeeper',
    group  => 'zookeeper',
    mode   => '755',
  }

  ->

  # Initialize the zookeeper data directory
  exec {'zookeeper-initialize':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'zookeeper',
    command   => 'zookeeper-server-initialize',
    logoutput => on_failure,
    creates   => '/var/lib/zookeeper/version-2',
    timeout   => 0,
  }

}
