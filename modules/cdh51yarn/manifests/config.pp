class cdh51yarn::config {

  $resourcemanagerhostname = $::cdh51yarn::resourcemanagerhostname
  $namenodehostname        = $::cdh51yarn::namenodehostname

  file { "/etc/hadoop/conf/yarn-site.xml":
    ensure  => present,
    content => template("cdh51yarn/yarn-site.xml.erb"),
    owner   => "root",
    group   => "root",
    notify  => Service['hadoop-yarn-nodemanager'],
  }

  ->

  file { "/etc/hadoop/conf/mapred-site.xml":
    ensure  => present,
    content => template("cdh51yarn/mapred-site.xml.erb"),
    owner   => "root",
    group   => "root",
    notify  => Service['hadoop-yarn-nodemanager'],
  }

  ->
  
  file { [ '/data/1/yarn', '/data/1/yarn/local', '/data/1/yarn/logs']:
    ensure => "directory",
    owner  => 'yarn',
    group  => 'yarn',
    mode   => '755',
  }

  ->

  exec {'yarn-history':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir -p /user/history',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user/history',
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
    unless    => 'hadoop fs -ls /user | grep /var/log/hadoop-yarn | grep mapred',
    timeout   => 0,
  }

  
}
