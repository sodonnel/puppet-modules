class cdh::namenode::install {
  
  package { [hadoop-hdfs-namenode, hadoop-hdfs-secondarynamenode]:
    ensure => present,
  }

  ->

  exec {'namenode-cp-etc-config':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => 'cp -n  /etc/alternatives/hadoop-conf/* /etc/hadoop/conf',
    logoutput => on_failure,
    timeout   => 0,
  }
 
}
