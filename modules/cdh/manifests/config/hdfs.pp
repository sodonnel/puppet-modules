class cdh::config::hdfs {
  
  $namenodehostname = $::cdh::config::namenodehostname

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

}
