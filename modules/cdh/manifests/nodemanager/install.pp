class cdh::nodemanager::install {

  package { [hadoop-yarn-nodemanager]:
    ensure => present,
  }
  
}
