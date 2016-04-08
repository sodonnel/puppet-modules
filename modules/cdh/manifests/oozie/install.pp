class cdh::oozie::install {

  package { ['oozie']:
    ensure => present,
  }

}