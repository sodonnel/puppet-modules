class passenger::install {

  package { [ruby-devel, rubygems, gcc]:
    ensure => present,
  }

  package { [rack]:
    provider => gem,
    ensure   => present
  }

  package { [passenger]:
    provider => gem,
    ensure   => '4.0.52',
  }
 
}
