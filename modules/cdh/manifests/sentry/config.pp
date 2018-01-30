class cdh::sentry::config(
  $dbhost    = 'localhost',
  $dbuser    = 'sentry',
  $dbpass    = 'sentry',
  $use_embedded_db = false,
) {


  if ($use_embedded_db == true) {
    $db_type = 'derby'
  } else {
    $db_type = 'mysql'
  }

  file { "/etc/sentry/conf/sentry-site.xml":
    ensure  => present,
    content => template("cdh/sentry-site.xml.erb"),
    owner   => "root",
    group   => "root",
  }

  ->

  file { '/usr/lib/sentry/lib/mysql-connector-java.jar':
    ensure => 'link',
    target => '/usr/share/java/mysql-connector-java.jar',
  }

  ->

  # TODO - this step is not re-runable. It will fail if the DB already has the tables loaded
  exec {'sentry-db-init':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'sentry',
    command   => "sentry --command schema-tool --conffile /etc/sentry/conf/sentry-site.xml --dbType ${db_type} --initSchema",
    logoutput => on_failure,
    timeout   => 0,
  }

  ->

  exec {'sentry-generate-principal':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => 'kadmin -p root/admin -w vagrant -q "addprinc -randkey sentry/$(hostname)"',
    logoutput => on_failure,
    unless    => "ls /etc/sentry/conf/sentry.keytab",
    timeout   => 0,
  }

  ->

  exec {'sentry-generate-keytab':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'root',
    command   => 'kadmin -p root/admin -w vagrant -q "ktadd -k /etc/sentry/conf/sentry.keytab sentry/$(hostname)"',
    logoutput => on_failure,
    unless    => "ls /etc/sentry/conf/sentry.keytab",
    timeout   => 0,
  }

  ->

  file {'/etc/sentry/conf/sentry.keytab':
    owner => 'sentry',
    mode  => '600',
  }

}