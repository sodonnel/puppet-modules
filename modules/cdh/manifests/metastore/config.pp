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

  ->

  exec {'oozie-user':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir -p /user/oozie',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user/oozie',
    timeout   => 0,
  }

  ->

  exec {'oozie-user-permissions':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chown oozie:oozie /user/oozie',
    logoutput => on_failure,
    # The -P switch for grep turns on Perl regexes
    unless    => 'hadoop fs -ls /user | grep /user/oozie | grep -P "oozie\s+oozie"',
    timeout   => 0,
  }
  
  ->

  exec {'oozie-shared-lib':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => "oozie-setup sharelib create -fs hdfs://${::cdh::config::namenodehostname} -locallib /usr/lib/oozie/oozie-sharelib-yarn.tar.gz",
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user/oozie/share/lib',
    timeout   => 0,
  }

}
