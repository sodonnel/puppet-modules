class cdh::metastore::install {

  package { ['hive-metastore']:
    ensure => present,
  }

}
