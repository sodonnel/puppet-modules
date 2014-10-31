class cdh51resourcemanager::install {

  package { [hadoop-mapreduce-historyserver, hadoop-yarn-proxyserver, hadoop-yarn-resourcemanager]:
    ensure => present,
  }
  
}
