class cdh51namenode::tmpdir {

  exec {'namenode-tmpdir':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir /tmp',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /tmp',
    timeout   => 0,
  }

  ->

  exec {'namenode-tmpdir-permissions':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chmod -R 1777 /tmp',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls / | grep /tmp | grep drwxrwxrwt',
    timeout   => 0,
  }
  
}
