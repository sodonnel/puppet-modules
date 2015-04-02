class cdh51java {

  # This package is a custom package and need to be deployed
  # on localyumrepo

  # These two RPMs are expected to be in the vagrant directroy under /vagrant/rpms.
  # This code would need to be changed to serve the files from yum repo if this module
  # was used on a puppet master for instance.
  package { [javajdk]:
    provider => 'rpm',
    source => '/vagrant/rpms/javajdk-1.7.0-55.x86_64.rpm',
    ensure => present,
  }

  package { [maven]:
    provider => 'rpm',
    source => '/vagrant/rpms/apache-maven-3.2.5-1.x86_64.rpm',
    ensure => present,
  }

}

