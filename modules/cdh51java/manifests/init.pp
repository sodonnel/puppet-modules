class cdh51java {

  # This package is a custom package and need to be deployed
  # on localyumrepo
  package { 'javajdk':
    ensure => present,
    provider => 'rpm',
    source => 'file:///puppet_modules/rpms/javajdk-1.7.0-79.x86_64.rpm'
  }

}

