class cdh::client::install {

  package { [hadoop-client, hive, oozie, spark-core]:
    ensure => present,
  }
  
}
