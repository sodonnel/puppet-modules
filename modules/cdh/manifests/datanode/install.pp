class cdh::datanode::install {

  package { [hadoop-hdfs-datanode]:
    ensure => present,
  }
  
}
