class passenger::install {

  package { [ruby-devel, rubygems, gcc]:
    ensure => present,
  }
  
  ->

  package { [rack]:
    provider => gem,
    ensure   => present
  }

  ->

  package { [passenger]:
    provider => gem,
    ensure   => $::passenger::passenger_version,
  }
 
}
