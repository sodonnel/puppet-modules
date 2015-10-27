class cdh51java {

  # These two RPMs are expected to be in the vagrant directroy under /vagrant/rpms.
  # This code would need to be changed to serve the files from yum repo if this module
  # was used on a puppet master for instance.
  package { 'javajdk':
    ensure => present,
    provider => 'rpm',
    source => 'file:///puppet_modules/rpms/javajdk-1.7.0-79.x86_64.rpm'
  }

}

