class cdh::config::hdfs {
  
  $namenodehostname = $::cdh::config::namenodehostname
  $secure           = $::cdh::config::secure
  $encryption       = $::cdh::config::encryption

  file { "/etc/hadoop/conf/hdfs-site.xml":
    ensure  => present,
    content => template("cdh/hdfs-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  file { "/etc/hadoop/conf/core-site.xml":
    ensure  => present,
    content => template("cdh/core-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  file { "/etc/hadoop/conf/ssl-server.xml":
    ensure  => present,
    content => template("cdh/ssl-server.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  file { "/etc/hadoop/conf/ssl-client.xml":
    ensure  => present,
    content => template("cdh/ssl-client.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  file { "/etc/default/hadoop-hdfs-datanode":
    ensure  => present,
    content => template("cdh/hadoop-hdfs-datanode.erb"),
    owner   => "root",
    group   => "root",
    mode    => '644',
  }

}
