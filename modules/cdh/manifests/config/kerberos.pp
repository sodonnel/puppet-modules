class cdh::config::kerberos {
  
  $namenodehostname = $::cdh::config::namenodehostname
  $secure           = $::cdh::config::secure

  file { "/root/create_principals.sh":
    ensure  => present,
    content => template("cdh/create_principals.sh.erb"),
    owner   => "root",
    group   => "root",
    mode    => "700",
  }

  ->

  exec {'generate-principals':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => '/root/create_principals.sh',
    logoutput => on_failure,
    creates   => "/root/keytabs_generated",
    timeout   => 0,
  }

}