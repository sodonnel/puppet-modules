class passenger::compile {

  exec {'compile-passenger':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    command   => 'passenger-install-apache2-module -a',
    logoutput => on_failure,
    creates   => '/usr/local/share/gems/gems/passenger-4.0.52/buildout/apache2/mod_passenger.so',
    timeout   => 0,
  }

}
