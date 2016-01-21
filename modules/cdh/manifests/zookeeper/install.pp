class cdh::zookeeper::install {

  package { ['zookeeper-server']:
    ensure => present,
  }

}