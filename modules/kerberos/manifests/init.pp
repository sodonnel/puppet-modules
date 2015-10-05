class kerberos {

  package { [krb5-libs, krb5-server, krb5-workstation]:
    ensure => present,
  }

  ->

  file { "/etc/krb5.conf":
    ensure => present,
    content => template("kerberos/krb5.conf.erb"),
    owner => "root",
    group => "root",
    mode => "644",
  }

  ->

  file { "/var/kerberos/krb5kdc/kdc.conf":
    ensure => present,
    content => template("kerberos/kdc.conf.erb"),
    owner => "root",
    group => "root",
    mode => "644",
  }

  ->

  file { "/var/kerberos/create_principal.sh":
    ensure => present,
    content => template("kerberos/create_principal.sh.erb"),
    owner => "root",
    group => "root",
    mode => "700",
  }

  ->

  exec {'create-kdc':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => '/usr/sbin/kdb5_util create -s -W -P vagrant',
    logoutput => on_failure,
    creates   => "/var/kerberos/krb5kdc/principal",
    timeout   => 0,
  }

  ->

  exec {'create-initial-princ':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => '/var/kerberos/create_principal.sh',
    logoutput => on_failure,
    creates   => "/var/kerberos/created_principal",
    timeout   => 0,
  }

  ->

  service { "krb5kdc":
    name        => krb5kdc,
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

  ->

  service { "kadmin":
    name        => kadmin,
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
  }

}
