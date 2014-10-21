class passenger::config {

  require passenger::compile

  file { "/etc/httpd/conf.d/enable_passenger.conf":
      ensure => present,
      source => "puppet:///modules/passenger/enable_passenger.conf",
      owner => "root",
      group => "root",
  }

}