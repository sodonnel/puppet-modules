class cdh::hive::config
{

  $secured           = $cdh::hive::secure
  $metastorehostname = $cdh::hive::metastorehostname
  $mysqlusername     = $cdh::hive::mysqlusername
  $mysqlpassword     = $cdh::hive::mysqlpassword

  if $cdh_version  =~ /^5\.3/ {
    $hive_version = '0.13.0'
  }  
  elsif $cdh_version  =~ /^5\.(4|5|6|7|8|9|10|11|12|13|14)/ {
    $hive_version = '1.1.0'
  }

  if ($secured) {

    exec {'hive-generate-principal':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "addprinc -randkey hive/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/hive/conf/hive.keytab",
      timeout   => 0,
    }

    ->

    exec {'hive-generate-keytab':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "ktadd -k /etc/hive/conf/hive.keytab hive/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/hive/conf/hive.keytab",
      timeout   => 0,
    }

    ->

    file {'/etc/hive/conf/hive.keytab':
      owner => 'root',
      mode  => '644',
    }
  }

  mysql::db { 'metastore':
    user     => $mysqlusername,
    password => $mysqlpassword,
    sql      => "/usr/lib/hive/scripts/metastore/upgrade/mysql/hive-schema-${hive_version}.mysql.sql",
    cwd => "/usr/lib/hive/scripts/metastore/upgrade/mysql",
    grant => ['ALL']
  }

  ->
  
  file { '/usr/lib/hive/lib/mysql-connector-java.jar':
    ensure => 'link',
    target => '/usr/share/java/mysql-connector-java.jar',
  }

  ->
   
  file { "/usr/lib/hive/conf/hive-site.xml":
    ensure  => present,
    content => template("cdh/hive-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  ->

  cdh::kinit { 'hiveConfig':  
  }
  
  -> 

  exec {'hive-user':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir -p /user/hive/warehouse',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user/hive/warehouse',
    timeout   => 0,
  }

  ->

  exec {'hive-user-permissions':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chmod -R 1777 /user/hive',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user | grep /user/hive | grep drwxrwxrwt',
    timeout   => 0,
  }

}