class cdh51datanode::install {

  package { [hadoop-hdfs-datanode, hadoop-mapreduce]:
    ensure => present,
  }
  
}
