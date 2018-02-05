define cdh::kinit(
  $os_user   = "hdfs",
  $keytab    = "/etc/hadoop/conf/hdfs.keytab",
  $principal = "hdfs/${hostname}"
){

  if ($cdh::config::secure) {

    exec {"kinit-${principal}-from-${name}":
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => $os_user,
      command   => "kinit ${principal} -kt ${keytab}",
      logoutput => on_failure,
      timeout   => 0,
    }
    
  }

}