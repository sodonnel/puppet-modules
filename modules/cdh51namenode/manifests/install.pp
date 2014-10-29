class cdh51namenode::install {
  
  package { [hadoop-hdfs-namenode]:
    ensure => present,
  }
 
}
