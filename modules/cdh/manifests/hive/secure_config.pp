class cdh::hive::secure_config
{

  if ($cdh::hive::secure) {
    exec {'hive-generate-principal':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "addprinc -randkey hive/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/hive/conf/hive.keytab",
      timeout   => 0,
    }

    ->

    exec {'hive-generate-keytab':
      path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
      user      => 'root',
      command   => 'kadmin -p root/admin -w vagrant -q "ktadd -k /etc/hive/conf/hive.keytab hive/$(hostname)"',
      logoutput => on_failure,
      unless    => "ls /etc/hive/conf/hive.keytab",
      timeout   => 0,
    }

    ->

    file {'/etc/hive/conf/hive.keytab':
      owner => 'root',
      mode  => '644',
    }
  }

}