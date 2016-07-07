class cdh::oozie::config(
  $secure = false,
  $dbhost    = 'localhost',
  $dbuser    = 'oozieuser',
  $dbpass    = 'secret',
  $namenodehostname = 'namenode',
){


  $secured       = $secure
  $mysqlhost     = $dbhost
  $mysqlusername = $dbuser
  $mysqlpassword = $dbpass
  $oozieHost     = $hostname


  if $cdh_version  =~ /^5\.3/ {
    # $oozie_lib_command = "oozie-setup sharelib create -fs hdfs://${::cdh::config::namenodehostname} -locallib /usr/lib/oozie/oozie-sharelib-yarn.tar.gz"
    $oozie_lib_command = "oozie-setup sharelib create -fs hdfs://${namenodehostname} -locallib /usr/lib/oozie/oozie-sharelib-yarn.tar.gz"
  }  
  else {
    $oozie_lib_command = "oozie-setup sharelib create -fs hdfs://${namenodehostname} -locallib /usr/lib/oozie/oozie-sharelib-yarn"
  }

  if $secure  == true {

    file { '/etc/oozie/conf/oozie.keytab':
      ensure => 'present',
      source => 'file:///etc/hadoop/conf/oozie.keytab',
      owner  => 'oozie',
      mode   => '600',
    }

  }


  file { '/var/lib/oozie/mysql-connector-java.jar':
    ensure => 'link',
    target => '/usr/share/java/mysql-connector-java.jar',
  }

  ->

  file { "/etc/oozie/conf/oozie-site.xml":
    ensure  => present,
    content => template("cdh/oozie-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  ->

  exec {'oozie-user':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir -p /user/oozie',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user/oozie',
    timeout   => 0,
  }

  ->

  exec {'oozie-user-permissions':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chown oozie:oozie /user/oozie',
    logoutput => on_failure,
    # The -P switch for grep turns on Perl regexes
    unless    => 'hadoop fs -ls /user | grep /user/oozie | grep -P "oozie\s+oozie"',
    timeout   => 0,
  }
  
  ->

  exec {'oozie-shared-lib':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    # Prior to CDH 5.4?
    # command   => "oozie-setup sharelib create -fs hdfs://${::cdh::config::namenodehostname} -locallib /usr/lib/oozie/oozie-sharelib-yarn.tar.gz",
    # CDH 5.4 and later...
    command   => $oozie_lib_command,
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user/oozie/share/lib/lib_*',
    timeout   => 0,
  }


}
