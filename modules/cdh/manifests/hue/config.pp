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

  if ($secure == true) {

    exec {'hue-generate-principal':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "addprinc -randkey hue/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/hue/conf/hue.keytab",
      timeout   => 0,
    }

    ->

    exec {'hue-generate-keytab':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "ktadd -k /etc/hue/conf/hue.keytab hue/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/hue/conf/hue.keytab",
      timeout   => 0,
    }

    ->

    file {'/etc/hue/conf/hue.keytab':
      owner => 'hue',
      mode  => '644',
    }

  }

}