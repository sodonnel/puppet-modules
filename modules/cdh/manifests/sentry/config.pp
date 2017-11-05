class cdh::sentry::config(
  $dbhost    = 'localhost',
  $dbuser    = 'sentry',
  $dbpass    = 'sentry',
) {


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
    user      => 'root',
    command   => 'sentry --command schema-tool --conffile /etc/sentry/conf/sentry-site.xml --dbType mysql --initSchema',
    logoutput => on_failure,
#    unless    => 'hadoop fs -ls /user/oozie/share/lib/lib_*',
    timeout   => 0,
  }

}