class cdh51namenode::config {

  $namenodehostname = $::cdh51namenode::hostname
  
  file { "/etc/hadoop/conf/hdfs-site.xml":
    ensure  => present,
    content => template("cdh51namenode/hdfs-site.xml.erb"),
    owner   => "root",
    group   => "root",
    notify  => Service['hadoop-hdfs-namenode'],
  }

  file { "/etc/hadoop/conf/core-site.xml":
    ensure  => present,
    content => template("cdh51namenode/core-site.xml.erb"),
    owner   => "root",
    group   => "root",
    notify  => Service['hadoop-hdfs-namenode'],
  }
  
}
