class cdh51namenode::config {

  host { $::cdh51namenode::hostname:
    ip => '192.168.57.6',
  }
  
  file { "/etc/hadoop/conf/hdfs-site.xml":
    ensure => present,
    content => template("cdh51namenode/hdfs-site.xml.erb"),
    owner => "root",
    group => "root",
  }

  file { "/etc/hadoop/conf/core-site.xml":
    ensure => present,
    content => template("cdh51namenode/core-site.xml.erb"),
    owner => "root",
    group => "root",
  }
  
}
