class cdh::datanode::config {

  file { [ "/data", '/data/1' ]:
    ensure => "directory",
    owner  => 'hdfs',
    group  => 'hdfs',
    mode   => '755',
  }

  ->
  
  file { [ '/data/1/dfs', '/data/1/dfs/dn' ]:
    ensure => "directory",
    owner  => 'hdfs',
    group  => 'hdfs',
    mode   => '700',
  }

  ->

  file { [ '/data/1/yarn', '/data/1/yarn/local', '/data/1/yarn/logs']:
    ensure => "directory",
    owner  => 'yarn',
    group  => 'yarn',
    mode   => '755',
  }
  
}
