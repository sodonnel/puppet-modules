class cdh::namenode::install {
  
  package { [hadoop-hdfs-namenode]:
    ensure => present,
  }
 
}
