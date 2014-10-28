class passenger::config {

  require passenger::compile

  file { "/etc/httpd/conf.d/enable_passenger.conf":
    ensure => present,
    content => template("passenger/enable_passenger.conf.erb"),
    owner => "root",
    group => "root",
    notify  => Service["httpd"]
  }

}
