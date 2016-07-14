class cdh::namenode::install {
  
  package { [hadoop-hdfs-namenode, hadoop-hdfs-secondarynamenode]:
    ensure => present,
  }
 
}
