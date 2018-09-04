class cdh::initNamenode
{

  cdh::kinit { 'initNamenode':  
  }

  ->

  exec {'namenode-waitonsafemode':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => 'hdfs dfsadmin -safemode wait',
    logoutput => on_failure,
    timeout   => 0,
  }

  ->

  file {'/tmp/init-hdfs.sh':
    ensure => present,
    content => template("cdh/init-hdfs.sh"),
    owner   => 'hdfs',
    group   => 'hdfs',
    mode    => '755'
  }

  -> 

  exec {'namenode-tmpdir':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    user      => 'hdfs',
    command   => '/tmp/init-hdfs.sh',
    logoutput => on_failure,
    unless    => "hadoop fs -ls /tmp",
    timeout   => 0,
  }

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