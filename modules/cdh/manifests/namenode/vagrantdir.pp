class cdh::namenode::vagrantdir {

  exec {'namenode-vagrantdir':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -mkdir -p /user/vagrant',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user/vagrant',
    timeout   => 0,
  }

  ->

  exec {'namenode-vagrantdir-owner':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hadoop fs -chown vagrant:vagrant /user/vagrant',
    logoutput => on_failure,
    unless    => 'hadoop fs -ls /user | grep /vagrant | grep "vagrant\s*vagrant"',
    timeout   => 0,
  }
  
}
