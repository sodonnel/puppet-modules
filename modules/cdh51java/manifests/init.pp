class cdh51java {

  # This package is a custom package and need to be deployed
  # on localyumrepo
  package { [javajdk]:
    ensure => present,
  }

}

