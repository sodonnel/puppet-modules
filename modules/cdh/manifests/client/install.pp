class cdh::client::install {

  package { [hadoop-client, hive]:
    ensure => present,
  }
  
}
