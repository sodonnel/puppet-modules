class cdh51yarn::install {

  package { [hadoop-yarn-nodemanager]:
    ensure => present,
  }
  
}
