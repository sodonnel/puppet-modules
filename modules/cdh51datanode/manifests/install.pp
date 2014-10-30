class cdh51datanode::install {

  package { [hadoop-yarn-nodemanager, hadoop-hdfs-datanode, hadoop-mapreduce]:
    ensure => present,
  }
  
}
