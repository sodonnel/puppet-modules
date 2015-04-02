class cdh::datanode::install {

  package { [hadoop-hdfs-datanode, hadoop-mapreduce, hadoop-yarn-nodemanager, hive, spark-core, spark-worker, sqoop]:
    ensure => present,
  }
  
}
