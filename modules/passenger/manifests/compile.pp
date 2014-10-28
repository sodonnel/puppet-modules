class passenger::compile {

  require passenger::install

  exec {'compile-passenger':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    command   => 'passenger-install-apache2-module -a',
    logoutput => on_failure,
    creates   => "/usr/local/share/gems/gems/passenger-${::passenger::passenger_version}/buildout/apache2/mod_passenger.so",
    timeout   => 0,
  }

}
