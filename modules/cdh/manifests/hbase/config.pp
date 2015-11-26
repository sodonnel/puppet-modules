class cdh::hbase::config (
  $namenodehostname        = 'mycluster',
  $zookeeper_ensemble      = 'localhost:2181',
  $secure                  = false,
) {

  $hostname  = $fqdn
  $namenode  = $namenodehostname
  $zookeeper = $zookeeper_ensemble
  $isSecure  = $secure

  file { "/etc/hbase/conf/hbase-site.xml":
    ensure  => present,
    content => template("cdh/hbase-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }


  file { "/etc/hbase/conf/hbase-env.sh":
    ensure  => present,
    content => template("cdh/hbase-env.sh.erb"),
    owner   => "root",
    group   => "root",
  }


  if ($secure == true) {

    exec {'hbase-generate-keytab':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "ktadd -k /etc/hbase/conf/hbase.keytab hbase/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/hbase/conf/hbase.keytab",
      timeout   => 0,
    }

    ->

    file {'/etc/hbase/conf/hbase.keytab':
      owner => 'hbase',
      mode  => '600',
    }

    ->

    file { "/etc/hbase/conf/zk-jaas.conf":
      ensure  => present,
      content => template("cdh/hbase-zk-jaas.conf.erb"),
      owner   => "root",
      group   => "root",
    }


  }

}
