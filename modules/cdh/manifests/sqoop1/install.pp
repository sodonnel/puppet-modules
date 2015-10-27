class cdh::sqoop1::install {

  package { [sqoop]:
    ensure => present,
  }

  ->
  # This package is a custom package and need to be deployed
  # on localyumrepo
  package { 'sqoopjdbc':
    ensure => present,
    provider => 'rpm',
    source => 'file:///puppet_modules/rpms/sqoopjdbc-1.0.0-1.x86_64.rpm'
  }
  
}
