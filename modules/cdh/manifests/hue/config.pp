class cdh::hue::config(
  $namenodehostname        = namenode,
  $metastorehostname       = metastore,
  $resourcemanagerhostname = resourcemanager,
  $secure                  = false,
)
{
  $hueHost = $hostname

  file { "/etc/hue/conf/hue.ini":
    ensure  => present,
    content => template("cdh/hue.ini.erb"),
    owner   => "root",
    group   => "root",
  }

  ->

  class{ 'cdh::hue::secure_config':
    secure => $secure
  }

  ->

  # This is needed due to a bug in the CDH startup script that incorrectly
  # specifies the pid file location as /usr/lib/hue/pids/supervistor.pid
  file { "/usr/lib/hue/pids":
    ensure => 'link',
    target => '/var/run/hue',
  }

}