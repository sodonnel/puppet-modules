class cdh::config::kerberos {
  
  $namenodehostname = $::cdh::config::namenodehostname
  $secure           = $::cdh::config::secure

  file { "/root/create_principals.sh":
    ensure  => present,
    content => template("cdh/create_principals.sh.erb"),
    owner   => "root",
    group   => "root",
    mode    => "700",
  }

  ->

  exec {'generate-principals':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => '/root/create_principals.sh',
    logoutput => on_failure,
    creates   => "/root/keytabs_generated",
    timeout   => 0,
  }

  ->

  exec {'kerberos-auth-hdfs':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'kinit hdfs/$(hostname) -kt /etc/hadoop/conf/hdfs.keytab',
    logoutput => on_failure,
    timeout   => 0,
  }

  ->
  # Hack to allow root to run hdfs ls command to check if directories
  # exist for some steps
  exec {'kerberos-auth-root':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => 'kinit hdfs/$(hostname) -kt /etc/hadoop/conf/hdfs.keytab',
    logoutput => on_failure,
    timeout   => 0,
  }

}