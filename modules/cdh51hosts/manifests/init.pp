class cdh51hosts {

  file { '/etc/hosts':
    ensure  => file,
    source => "puppet:///modules/cdh51hosts/hosts",
  }
  
}
