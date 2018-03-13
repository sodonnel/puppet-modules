class cdh::hue::secure_config(
  $secure     = false,
) {

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
