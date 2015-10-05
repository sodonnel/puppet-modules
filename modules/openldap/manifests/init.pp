class openldap(
  $basedn = 'appsintheopen',
) {

  package { [openldap, openldap-clients, openldap-servers]:
    ensure => present,
  }

  ->

  file { "/etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif":
    ensure => present,
    content => template("openldap/olcDatabase_2_.ldif.erb"),
    owner => "ldap",
    group => "ldap",
    mode => "600",
  }

  ->

  service { "slapd":
    name        => slapd,
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

  ->

  file { "/etc/openldap/slapd.d/base.ldif":
    ensure => present,
    content => template("openldap/base.ldif.erb"),
    owner => "root",
    group => "root",
    mode => "600",
  }

  ->

  file { "/etc/openldap/slapd.d/groups.ldif":
    ensure => present,
    content => template("openldap/groups.ldif.erb"),
    owner => "root",
    group => "root",
    mode => "600",
  }

  -> 

  file { "/etc/openldap/slapd.d/users.ldif":
    ensure => present,
    content => template("openldap/users.ldif.erb"),
    owner => "root",
    group => "root",
    mode => "600",
  }

  ->

  file { "/etc/openldap/slapd.d/load.sh":
    ensure => present,
    content => template("openldap/load.sh.erb"),
    owner => "root",
    group => "root",
    mode => "700",
  }

  ->

  file { "/etc/openldap/slapd.d/passwords.sh":
    ensure => present,
    content => template("openldap/passwords.sh.erb"),
    owner => "root",
    group => "root",
    mode => "700",
  }


  ->

  exec {'load-base':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => '/etc/openldap/slapd.d/load.sh base',
    logoutput => on_failure,
    creates   => "/etc/openldap/slapd.d/base_loaded",
    timeout   => 0,
  }

  ->

  exec {'load-groups':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => '/etc/openldap/slapd.d/load.sh groups',
    logoutput => on_failure,
    creates   => "/etc/openldap/slapd.d/groups_loaded",
    timeout   => 0,
  }

  ->

  exec {'load-users':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => '/etc/openldap/slapd.d/load.sh users',
    logoutput => on_failure,
    creates   => "/etc/openldap/slapd.d/users_loaded",
    timeout   => 0,
  }

  ->


  exec {'setpasswords':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => '/etc/openldap/slapd.d/passwords.sh',
    logoutput => on_failure,
    creates   => "/etc/openldap/slapd.d/passwords_loaded",
    timeout   => 0,
  }

}