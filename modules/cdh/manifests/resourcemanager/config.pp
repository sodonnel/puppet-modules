class cdh::resourcemanager::config {

  exec {'yarn-history':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir -p /user/history',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user/history',
    timeout   => 0,
  }

  ->

  exec {'yarn-user-permissions':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chmod 775 /user',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls / | grep /user | grep drwxrwxr-x',
    timeout   => 0,
  }

  ->
  
  exec {'yarn-history-permissions':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chmod -R 1777 /user/history',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user | grep /user/history | grep drwxrwxrwt',
    timeout   => 0,
  }

  ->
  
  exec {'yarn-history-owner':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chown mapred:hadoop /user/history',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user | grep /user/history | grep mapred',
    timeout   => 0,
  }

  ->

  exec {'yarn-log':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir -p /var/log/hadoop-yarn',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /var/log/hadoop-yarn',
    timeout   => 0,
  }

  ->

  exec {'yarn-log-owner':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chown yarn:mapred /var/log/hadoop-yarn',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /var/log | grep /var/log/hadoop-yarn | grep yarn\ mapred',
    timeout   => 0,
  }

  ->

  exec {'yarn-log-apps':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir -p /var/log/hadoop-yarn/apps',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /var/log/hadoop-yarn/apps',
    timeout   => 0,
  }

  ->

  exec {'yarn-log-apps-owner':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chown yarn:mapred /var/log/hadoop-yarn/apps',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /var/log/hadoop-yarn | grep /var/log/hadoop-yarn/apps | grep yarn\ mapred',
    timeout   => 0,
  }
  
}
