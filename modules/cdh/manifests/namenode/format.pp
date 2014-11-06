class cdh::namenode::format {
  exec {'format-namenode':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hdfs namenode -format',
    logoutput => on_failure,
    creates   => "/var/lib/hadoop-hdfs/cache/hdfs/dfs/name",
    timeout   => 0,
  }

}
