class cdh51java {

  require localyumrepo

  # This come from the local repo
  package { [javajdk]:
    ensure => present,
  }

}

