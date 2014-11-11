class cdh::client::install {

  package { [hadoop-client, hive, oozie]:
    ensure => present,
  }
  
}
