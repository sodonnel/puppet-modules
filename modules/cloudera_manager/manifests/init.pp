class cloudera_manager {

  package { [cloudera-manager-server-db-2, cloudera-manager-daemons, cloudera-manager-server]:
    ensure => present,
  }

  ->

  service { "cloudera-scm-server-db":
    name        => cloudera-scm-server-db,
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

  ->

  service { "cloudera-scm-server":
    name        => cloudera-scm-server,
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

}
