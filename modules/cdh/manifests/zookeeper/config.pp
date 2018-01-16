class cdh::zookeeper::config(
  $secure = false,
  $quorm  = [], # pass the hostnames as a list, eg ['host1', 'host2', 'host3']
  $instance_id = '1',
){

  $secured = $secure
  # Should not use fqdn - use hostname instead. $hostname is builtin
  # which is why this line is commented out
  # $hostname = $fqdn
  $quorm_list = $quorm
  $zkid       = $instance_id

  if ($secured == true) {

    file { "/etc/zookeeper/conf/java.env":
      ensure  => present,
      content => template("cdh/java.env.erb"),
      owner   => "root",
      group   => "root",
      mode    => "644",
    }

    ->

    file { "/etc/zookeeper/conf/jaas.conf":
      ensure  => present,
      content => template("cdh/jaas.conf.erb"),
      owner   => "root",
      group   => "root",
      mode    => "644",
    }

    ->

    exec {'zookeeper-generate-principal':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "addprinc -randkey zookeeper/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/zookeeper/conf/zookeeper.keytab",
      timeout   => 0,
    }

    ->

    exec {'zookeeper-generate-keytab':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "ktadd -k /etc/zookeeper/conf/zookeeper.keytab zookeeper/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/zookeeper/conf/zookeeper.keytab",
      timeout   => 0,
    }

    ->

    file {'/etc/zookeeper/conf/zookeeper.keytab':
      owner => 'zookeeper',
      mode  => '600',
    }

    
  }

  file { "/etc/zookeeper/conf/zoo.cfg":
    ensure  => present,
    content => template("cdh/zoo.cfg.erb"),
    owner   => "root",
    group   => "root",
    mode    => "644",
  }

  ->


  file { [ '/var/lib/zookeeper' ]:
    ensure => "directory",
    owner  => 'zookeeper',
    group  => 'zookeeper',
    mode   => '755',
  }

  ->

  # Initialize the zookeeper data directory. This wipes the datadir
  # including deleting the myid file!
  exec {'zookeeper-initialize':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'zookeeper',
    command   => 'zookeeper-server-initialize',
    logoutput => on_failure,
    creates   => '/var/lib/zookeeper/version-2',
    timeout   => 0,
  }

  ->

  file { [ '/var/lib/zookeeper/myid' ]:
    ensure => 'present',
    owner  => 'zookeeper',
    group  => 'zookeeper',
    mode   => '644',
    content => template("cdh/myid.erb"),
  }


}

