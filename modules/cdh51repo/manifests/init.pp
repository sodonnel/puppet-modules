class cdh51repo {
  file { "/etc/yum.repos.d/cloudera-cdh5.repo":
    ensure => present,
    source => "puppet:///modules/cdh51repo/cloudera-cdh5.repo",
    owner => "root",
    group => "root",
  }

  exec {'cdh51-repo-cleanall':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    command   => 'yum clean all',
    require   => File['/etc/yum.repos.d/cloudera-cdh5.repo']
  }
  
}
