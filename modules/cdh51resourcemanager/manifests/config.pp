class cdh51resourcemanager::config {

  $namenodehostname        = $::cdh51resourcemanager::namenodehostname
  $resourcemanagerhostname = $::cdh51resourcemanager::resourcemanagerhostname

  file { "/etc/hadoop/conf/core-site.xml":
    ensure  => present,
    content => template("cdh51namenode/core-site.xml.erb"),
    owner   => "root",
    group   => "root",
    notify  => Service['hadoop-mapreduce-historyserver', 'hadoop-yarn-proxyserver'],
  }  

  file { "/etc/hadoop/conf/yarn-site.xml":
    ensure  => present,
    content => template("cdh51yarn/yarn-site.xml.erb"),
    owner   => "root",
    group   => "root",
    notify  => Service['hadoop-mapreduce-historyserver', 'hadoop-yarn-proxyserver'],
  }

  file { "/etc/hadoop/conf/hdfs-site.xml":
    ensure  => present,
    content => template("cdh51namenode/hdfs-site.xml.erb"),
    owner   => "root",
    group   => "root",
    notify  => Service['hadoop-mapreduce-historyserver', 'hadoop-yarn-proxyserver'],
  }

  file { "/etc/hadoop/conf/mapred-site.xml":
    ensure  => present,
    content => template("cdh51yarn/mapred-site.xml.erb"),
    owner   => "root",
    group   => "root",
    notify  => Service['hadoop-mapreduce-historyserver', 'hadoop-yarn-proxyserver'],
  }
  
}
