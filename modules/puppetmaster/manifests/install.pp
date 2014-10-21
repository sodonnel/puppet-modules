class puppetmaster::install {

  package { [puppet-server]:
    ensure => present,
  }
  ->
  service { "puppetmaster":
    enable => false
  }
 
}
