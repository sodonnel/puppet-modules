class cloudera_director {

  package { [cloudera-director-server, cloudera-director-client]:
    ensure => present,
  }

  ->

  service { "cloudera-director-server":
    name        => cloudera-director-server,
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

}
