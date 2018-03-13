class cdh::search::config (
  $namenodehostname        = namenode,
  $zookeeper_ensemble      = 'localhost:2181/solr',
  $secure                  = false,
) {

  # Should not use fqdn - use hostname instead. $hostname is builtin
  # which is why this line is commented out
  # $hostname = $fqdn

  file { "/etc/default/solr":
    ensure  => present,
    content => template("cdh/solr_conf.erb"),
    owner   => "root",
    group   => "root",
  }   ->


  file { "/etc/solr/conf/log4j.properties":
    ensure  => present,
    content => template("cdh/solr_log4j.erb"),
    owner   => "root",
    group   => "root",
  }  ->

  class{ 'cdh::search::secure_config':
    namenodehostname   => $namenodehostname,
    zookeeper_ensemble => $zookeeper_ensemble,
    secure             => $secure
  } ->
  
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
  
