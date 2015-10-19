class cdh::search::config (
  $namenodehostname        = mycluster,
  $zookeeper_ensemble      = 'localhost:2181/solr',
  $secure                  = false,
) {

  $hostname = $fqdn

  file { "/etc/default/solr":
    ensure  => present,
    content => template("cdh/solr_conf.erb"),
    owner   => "root",
    group   => "root",
  }


  if ($secure == true) {

    exec {'kerberos-auth-hdfs':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'hdfs',
      command   => 'kinit hdfs/$(hostname) -kt /etc/hadoop/conf/hdfs.keytab',
      logoutput => on_failure,
      timeout   => 0,
    }

    ->

    exec {'solr-generate-keytab':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "ktadd -k /etc/solr/conf/solr.keytab solr/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/solr/conf/solr.keytab",
      timeout   => 0,
    }

    ->

    file {'/etc/solr/conf/solr.keytab':
      owner => 'solr',
      mode  => '600',
    }
    
  }


  exec {'solr-hdfs':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir /solr',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /solr',
    timeout   => 0,
  }

  ->

  exec {'solr-hdfs-owner':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chown solr /solr',
    logoutput => on_failure,
    unless    => "hadoop fs -ls / | grep solr | grep -E 'solr[[:space:]]+hadoop'",
    timeout   => 0,
  }

  -> 

  exec {'solr-zk-initialise':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'solrctl init',
    logoutput => on_failure,
    unless    => "zookeeper-client ls / | grep solr",
    timeout   => 0,
  }
    
}
  
