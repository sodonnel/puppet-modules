class cdh::initNamenode
{

  exec {'namenode-waitonsafemode':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hdfs dfsadmin -safemode wait',
    logoutput => on_failure,
    timeout   => 0,
  }

#  ->
#
#  exec {'namenode-tmpdir':
#    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
#    user      => 'root',
#    command   => '/usr/lib/hadoop/libexec/init-hdfs.sh',
#    logoutput => on_failure,
#    unless    => "su hdfs -c 'hadoop fs -ls /tmp'",
#    timeout   => 0,
#  }

  ->

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