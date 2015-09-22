class cdh51repo(
  $cdh_version = '5.4.5',
)
 {
  file { "/etc/yum.repos.d/cloudera-cdh5.repo":
    ensure => present,
    content => template("cdh51repo/cloudera-cdh5.repo"),
    owner => "root",
    group => "root",
  }

  exec {'cdh51-repo-cleanall':
    path      => ['/usr/bin', '/bin', '/usr/local/bin' ],
    command   => 'yum clean all',
    require   => File['/etc/yum.repos.d/cloudera-cdh5.repo']
  }
  
}
