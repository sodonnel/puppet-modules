class cdh51datanode::config {

  $namenodehostname = $::cdh51datanode::namenodehost

  require cdh51datanode::install
  
  file { [ "/data", '/data/1' ]:
    ensure => "directory",
    owner  => 'hdfs',
    group  => 'hdfs',
    mode   => '755',
  }

  file { [ '/data/1/dfs', '/data/1/dfs/dn' ]:
    ensure => "directory",
    owner  => 'hdfs',
    group  => 'hdfs',
    mode   => '700',
  }

  file { "/etc/hadoop/conf/hdfs-site.xml":
    ensure  => present,
    content => template("cdh51namenode/hdfs-site.xml.erb"),
    owner   => "root",
    group   => "root",
    notify  => Service['hadoop-hdfs-datanode'],
  }

  file { "/etc/hadoop/conf/core-site.xml":
    ensure  => present,
    content => template("cdh51namenode/core-site.xml.erb"),
    owner   => "root",
    group   => "root",
    notify  => Service['hadoop-hdfs-datanode'],
  }
  
}
