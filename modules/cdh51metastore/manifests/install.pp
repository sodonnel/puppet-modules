class cdh51metastore::install {

  package { ['hive-metastore']:
    ensure => present,
  }
 
}