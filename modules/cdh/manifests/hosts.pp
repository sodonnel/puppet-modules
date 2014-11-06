class cdh::hosts {

  file { '/etc/hosts':
    ensure  => file,
    source => "puppet:///modules/cdh/hosts",
  }
  
}
